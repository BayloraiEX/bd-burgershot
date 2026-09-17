(function () {
    const bossmenu = document.getElementById('bossmenu');
    const closeBtn = document.getElementById('bossCloseBtn');
    const tabs = document.querySelectorAll('.boss-nav-item');
    const sections = {
        overview: document.getElementById('overviewSection'),
        orders: document.getElementById('ordersSection'),
        stock: document.getElementById('stockSection'),
        management: document.getElementById('managementSection'),
        finances: document.getElementById('financesSection'),
    };
    const totalWorkersEl = document.getElementById('totalWorkers');
    const staffOnDutyEl = document.getElementById('staffOnDuty');
    const overviewBalanceValueEl = document.getElementById('overviewBalanceValue');
    const overviewChartEl = document.getElementById('overviewChart');
    const financesChartEl = document.getElementById('financesChart');
    const balanceValueEl = document.getElementById('balanceValue');
    const weeklyProfitEl = document.getElementById('weeklyProfit');
    const weeklyExpenseEl = document.getElementById('weeklyExpense');
    const transactionListEl = document.getElementById('transactionList');
    const fundsAmountInput = document.getElementById('fundsAmount');
    const fundsAccountSelect = document.getElementById('fundsAccount');
    const depositBtn = document.getElementById('depositBtn');
    const withdrawBtn = document.getElementById('withdrawBtn');
    const fundsErrorEl = document.getElementById('fundsError');
    const employeeListEl = document.getElementById('employeeList');
    const hireInput = document.getElementById('hireServerId');
    const hireBtn = document.getElementById('hireBtn');
    const bossError = document.getElementById('bossError');

    const supplyStatusBannerEl = document.getElementById('supplyStatusBanner');
    const orderCategoryTabsEl = document.getElementById('orderCategoryTabs');
    const orderItemGridEl = document.getElementById('orderItemGrid');
    const orderCartItemsEl = document.getElementById('orderCartItems');
    const orderCartTotalEl = document.getElementById('orderCartTotal');
    const orderClearBtn = document.getElementById('orderClearBtn');
    const orderSubmitBtn = document.getElementById('orderSubmitBtn');

    const stockListEl = document.getElementById('stockList');
    const stockRefreshBtn = document.getElementById('stockRefreshBtn');
    const stockUpdatedAtEl = document.getElementById('stockUpdatedAt');
    const stockErrorEl = document.getElementById('stockError');

    let state = {
        employees: [], grades: [], maxGrade: 0, balance: 0, transactions: [],
        supplyMenu: [], activeSupplyOrder: null,
        stock: { containers: [], items: [] },
    };

    // Supply cart - key: item code, value: { item, label, price, qty }
    let orderCart = {};
    let activeOrderCategory = 0;

    function money(n) {
        return `$${Number(n || 0).toFixed(0)}`;
    }

    // Transaction timestamps can come back as a MySQL datetime string
    // ("2026-07-11 12:00:00"), an ISO string, or a raw epoch number/string
    // (seconds or milliseconds) depending on how oxmysql serializes the
    // created_at column. Handle all of them so the chart and weekly totals
    // don't silently drop rows they can't parse.
    function parseTxDate(raw) {
        if (raw === null || raw === undefined || raw === '') return null;

        if (typeof raw === 'number') {
            const ms = raw < 10000000000 ? raw * 1000 : raw; // seconds vs ms
            const d = new Date(ms);
            return isNaN(d.getTime()) ? null : d;
        }

        const str = String(raw).trim();

        // Pure numeric string -> epoch timestamp
        if (/^\d+$/.test(str)) {
            return parseTxDate(Number(str));
        }

        // MySQL "YYYY-MM-DD HH:MM:SS" -> make it ISO-parseable
        const isoish = str.includes('T') ? str : str.replace(' ', 'T');
        const d = new Date(isoish);
        if (!isNaN(d.getTime())) return d;

        const d2 = new Date(str);
        return isNaN(d2.getTime()) ? null : d2;
    }

    function formatDate(raw) {
        const d = parseTxDate(raw);
        if (!d) return raw || '';
        return d.toLocaleString([], { month: 'short', day: 'numeric', hour: 'numeric', minute: '2-digit' });
    }

    function switchTab(tabName) {
        tabs.forEach(tab => tab.classList.toggle('active', tab.dataset.tab === tabName));
        Object.entries(sections).forEach(([name, el]) => el.classList.toggle('active', name === tabName));
    }

    tabs.forEach(tab => {
        tab.addEventListener('click', () => switchTab(tab.dataset.tab));
    });

    function getResourceName() {
        return (typeof GetParentResourceName === 'function')
            ? GetParentResourceName()
            : 'bd-burgershot';
    }

    async function nuiPost(endpoint, data) {
        try {
            const resp = await fetch(`https://${getResourceName()}/${endpoint}`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json; charset=UTF-8' },
                body: JSON.stringify(data || {})
            });
            return await resp.json();
        } catch (e) {
            return { ok: false, error: 'NUI communication failed.' };
        }
    }

    function showError(msg) {
        if (!bossError) return;
        bossError.textContent = msg || '';
        bossError.classList.toggle('visible', !!msg);
    }

    function applyPayload(payload) {
        if (!payload) return;
        if (payload.employees) state.employees = payload.employees;
        if (payload.grades) state.grades = payload.grades;
        if (typeof payload.maxGrade === 'number') state.maxGrade = payload.maxGrade;
        if (typeof payload.balance === 'number') state.balance = payload.balance;
        if (payload.transactions) state.transactions = payload.transactions;
        if (payload.supplyMenu) state.supplyMenu = payload.supplyMenu;
        if ('activeSupplyOrder' in payload) state.activeSupplyOrder = payload.activeSupplyOrder;
        if (payload.stock) state.stock = payload.stock;
        renderOverviewStats();
        renderFinances();
        renderEmployees();
        renderOrders();
        renderStock();
    }

    function computeWeeklyStats() {
        const weekAgo = Date.now() - (7 * 24 * 60 * 60 * 1000);
        let profit = 0;
        let expense = 0;

        state.transactions.forEach(tx => {
            const d = parseTxDate(tx.created_at);
            if (!d || d.getTime() < weekAgo) return;

            const amt = Number(tx.amount) || 0;
            if (tx.type === 'in') {
                profit += amt;
            } else if (tx.type === 'out') {
                expense += amt;
            }
        });

        return { profit, expense };
    }

    function aggregateByDay(transactions, days) {
        const buckets = [];
        const today = new Date();
        today.setHours(0, 0, 0, 0);

        for (let i = days - 1; i >= 0; i--) {
            const d = new Date(today);
            d.setDate(d.getDate() - i);
            buckets.push({
                time: d.getTime(),
                label: d.toLocaleDateString([], { month: 'short', day: 'numeric' }),
                in: 0,
                out: 0,
            });
        }

        const byTime = new Map(buckets.map(b => [b.time, b]));

        transactions.forEach(tx => {
            const txDate = parseTxDate(tx.created_at);
            if (!txDate) return;
            txDate.setHours(0, 0, 0, 0);

            const bucket = byTime.get(txDate.getTime());
            if (!bucket) return;

            const amt = Number(tx.amount) || 0;
            if (tx.type === 'in') {
                bucket.in += amt;
            } else if (tx.type === 'out') {
                bucket.out += amt;
            }
        });

        return buckets;
    }

    // Picks a "nice" axis max + step (1/2/5 * 10^n) so the y-axis reads
    // like $0 / $25 / $50 / $75 / $100 instead of jagged raw numbers.
    function getNiceScale(maxVal, tickCount) {
        if (maxVal <= 0) maxVal = 1;
        const rawStep = maxVal / tickCount;
        const magnitude = Math.pow(10, Math.floor(Math.log10(rawStep)));
        const residual = rawStep / magnitude;
        let niceResidual;
        if (residual > 5) niceResidual = 10;
        else if (residual > 2) niceResidual = 5;
        else if (residual > 1) niceResidual = 2;
        else niceResidual = 1;
        const step = niceResidual * magnitude;
        const niceMax = step * tickCount;
        return { step, niceMax };
    }

    function buildMoneyChartSVG(data) {
        const width = 640;
        const height = 210;
        const paddingLeft = 52;
        const paddingRight = 12;
        const paddingTop = 14;
        const paddingBottom = 26;
        const chartWidth = width - paddingLeft - paddingRight;
        const chartHeight = height - paddingTop - paddingBottom;
        const baseY = paddingTop + chartHeight;

        const rawMax = Math.max(1, ...data.map(d => Math.max(d.in, d.out)));
        const tickCount = 4;
        const { step, niceMax } = getNiceScale(rawMax, tickCount);

        const xStep = data.length > 1 ? chartWidth / (data.length - 1) : 0;
        const x = i => paddingLeft + (data.length > 1 ? i * xStep : chartWidth / 2);
        const y = val => paddingTop + chartHeight - (val / niceMax) * chartHeight;

        const labelEvery = data.length > 10 ? Math.ceil(data.length / 8) : 1;

        // ---- horizontal gridlines + $ labels on the left ----
        let grid = '';
        for (let t = 0; t <= tickCount; t++) {
            const val = step * t;
            const gy = y(val);
            grid += `<line class="grid-line" x1="${paddingLeft}" y1="${gy.toFixed(1)}" x2="${width - paddingRight}" y2="${gy.toFixed(1)}"></line>`;
            grid += `<text class="axis-label-y" x="${paddingLeft - 8}" y="${(gy + 3).toFixed(1)}" text-anchor="end">${money(val)}</text>`;
        }

        // ---- date labels along the bottom ----
        let xLabels = '';
        data.forEach((d, i) => {
            if (i % labelEvery !== 0 && i !== data.length - 1) return;
            xLabels += `<text class="axis-label-x" x="${x(i).toFixed(1)}" y="${height - 6}" text-anchor="middle">${d.label}</text>`;
        });

        // Smooth a set of points into a Catmull-Rom-based cubic bezier path
        // so the line curves gently through each point instead of kinking.
        function smoothPathD(points) {
            if (points.length < 2) return '';
            let d = `M ${points[0].x.toFixed(1)},${points[0].y.toFixed(1)}`;
            for (let i = 0; i < points.length - 1; i++) {
                const p0 = points[i - 1] || points[i];
                const p1 = points[i];
                const p2 = points[i + 1];
                const p3 = points[i + 2] || p2;
                const cp1x = p1.x + (p2.x - p0.x) / 6;
                const cp1y = p1.y + (p2.y - p0.y) / 6;
                const cp2x = p2.x - (p3.x - p1.x) / 6;
                const cp2y = p2.y - (p3.y - p1.y) / 6;
                d += ` C ${cp1x.toFixed(1)},${cp1y.toFixed(1)} ${cp2x.toFixed(1)},${cp2y.toFixed(1)} ${p2.x.toFixed(1)},${p2.y.toFixed(1)}`;
            }
            return d;
        }

        // ---- line + area + glowing dots for a given series ----
        function buildSeries(key, lineClass, areaClass, dotClass, tooltipLabel) {
            if (data.length === 0) return '';

            const points = data.map((d, i) => ({ x: x(i), y: y(d[key]) }));
            const lineD = smoothPathD(points);
            const areaD = `${lineD} L ${points[points.length - 1].x.toFixed(1)},${baseY.toFixed(1)} L ${points[0].x.toFixed(1)},${baseY.toFixed(1)} Z`;

            let dots = '';
            data.forEach((d, i) => {
                dots += `<circle class="${dotClass} chart-dot-hit" filter="url(#dotGlow)" cx="${points[i].x.toFixed(1)}" cy="${points[i].y.toFixed(1)}" r="3" data-date="${d.label}" data-amount="${d[key]}" data-kind="${tooltipLabel}"></circle>`;
            });

            return `<path class="${areaClass}" d="${areaD}"></path>
                <path class="${lineClass}" d="${lineD}"></path>
                ${dots}`;
        }

        const inSeries = buildSeries('in', 'line-in', 'area-in', 'dot-in', 'Received');
        const outSeries = buildSeries('out', 'line-out', 'area-out', 'dot-out', 'Spent');

        return `<svg class="money-chart-svg" viewBox="0 0 ${width} ${height}">
            <defs>
                <filter id="dotGlow" x="-150%" y="-150%" width="400%" height="400%">
                    <feGaussianBlur stdDeviation="2.4" result="blur"></feGaussianBlur>
                    <feMerge>
                        <feMergeNode in="blur"></feMergeNode>
                        <feMergeNode in="SourceGraphic"></feMergeNode>
                    </feMerge>
                </filter>
            </defs>
            ${grid}
            <line class="chart-baseline" x1="${paddingLeft}" y1="${baseY}" x2="${width - paddingRight}" y2="${baseY}"></line>
            ${inSeries}
            ${outSeries}
            ${xLabels}
        </svg>`;
    }

    function renderMoneyChart(containerEl, days) {
        if (!containerEl) return;

        const data = aggregateByDay(state.transactions, days);
        const hasActivity = data.some(d => d.in > 0 || d.out > 0);

        if (!hasActivity) {
            containerEl.innerHTML = '<div class="money-chart-empty">No activity in this period.</div>';
            return;
        }

        containerEl.innerHTML = buildMoneyChartSVG(data);
        attachChartTooltip(containerEl);
    }

    // Builds a small floating tooltip that follows whichever dot is being
    // hovered, showing that day's exact amount for the received/spent line.
    function attachChartTooltip(containerEl) {
        const tooltip = document.createElement('div');
        tooltip.className = 'chart-tooltip';
        containerEl.appendChild(tooltip);

        function showTooltip(dot) {
            const date = dot.getAttribute('data-date') || '';
            const amount = Number(dot.getAttribute('data-amount')) || 0;
            const kind = dot.getAttribute('data-kind') || '';
            const kindClass = dot.classList.contains('dot-in') ? 'in' : 'out';

            tooltip.innerHTML = `<div class="chart-tooltip-date">${date}</div><div class="chart-tooltip-amount ${kindClass}">${kind}: ${money(amount)}</div>`;

            const dotRect = dot.getBoundingClientRect();
            const containerRect = containerEl.getBoundingClientRect();
            tooltip.style.left = `${(dotRect.left - containerRect.left) + dotRect.width / 2}px`;
            tooltip.style.top = `${dotRect.top - containerRect.top}px`;
            tooltip.classList.add('visible');
        }

        function hideTooltip() {
            tooltip.classList.remove('visible');
        }

        containerEl.querySelectorAll('.chart-dot-hit').forEach(dot => {
            dot.addEventListener('mouseenter', () => showTooltip(dot));
            dot.addEventListener('mouseleave', hideTooltip);
        });
    }

    function renderOverviewStats() {
        totalWorkersEl.textContent = state.employees.length;
        staffOnDutyEl.textContent = state.employees.filter(e => e.onduty).length;
        overviewBalanceValueEl.textContent = money(state.balance);
        renderMoneyChart(overviewChartEl, 7);
    }

    function renderFinances() {
        balanceValueEl.textContent = money(state.balance);

        const { profit, expense } = computeWeeklyStats();
        weeklyProfitEl.textContent = `+${money(profit)}`;
        weeklyExpenseEl.textContent = `-${money(expense)}`;

        renderMoneyChart(financesChartEl, 14);

        transactionListEl.innerHTML = '';

        if (!state.transactions.length) {
            const empty = document.createElement('div');
            empty.className = 'transaction-empty';
            empty.textContent = 'No activity yet.';
            transactionListEl.appendChild(empty);
            return;
        }

        state.transactions.forEach(tx => {
            const row = document.createElement('div');
            row.className = 'transaction-row';

            const desc = document.createElement('div');
            desc.className = 'transaction-desc';
            desc.textContent = tx.description || (tx.type === 'in' ? 'Payment received' : 'Payment made');

            const type = document.createElement('div');
            type.className = `transaction-type ${tx.type === 'out' ? 'out' : 'in'}`;
            type.textContent = tx.type === 'out' ? 'Withdraw' : 'Deposit';

            const amount = document.createElement('div');
            amount.className = 'transaction-amount';
            amount.textContent = `${tx.type === 'out' ? '-' : '+'}${money(tx.amount)}`;

            const date = document.createElement('div');
            date.className = 'transaction-date';
            date.textContent = formatDate(tx.created_at);

            row.appendChild(desc);
            row.appendChild(type);
            row.appendChild(amount);
            row.appendChild(date);
            transactionListEl.appendChild(row);
        });
    }

    /* =========================================================
       FINANCES TAB - deposit / withdraw
       ========================================================= */

    function showFundsError(msg) {
        if (!fundsErrorEl) return;
        fundsErrorEl.textContent = msg || '';
        fundsErrorEl.classList.toggle('visible', !!msg);
    }

    function resetFundsForm() {
        showFundsError('');
        if (fundsAmountInput) {
            fundsAmountInput.value = '';
            fundsAmountInput.classList.remove('input-error');
        }
    }

    function readFundsAmount() {
        const amount = parseInt(fundsAmountInput.value, 10);
        if (!amount || amount <= 0) {
            fundsAmountInput.classList.add('input-error');
            fundsAmountInput.focus();
            return null;
        }
        return amount;
    }

    async function submitFundsAction(endpoint) {
        const amount = readFundsAmount();
        if (amount === null) return;

        showFundsError('');
        depositBtn.disabled = true;
        withdrawBtn.disabled = true;

        const payload = await nuiPost(endpoint, { amount, account: fundsAccountSelect.value });

        depositBtn.disabled = false;
        withdrawBtn.disabled = false;

        if (!payload || !payload.ok) {
            showFundsError((payload && payload.error) || 'Action failed.');
        } else {
            fundsAmountInput.value = '';
        }
        applyPayload(payload);
    }

    if (depositBtn) {
        depositBtn.addEventListener('click', () => submitFundsAction('bossDeposit'));
    }
    if (withdrawBtn) {
        withdrawBtn.addEventListener('click', () => submitFundsAction('bossWithdraw'));
    }
    if (fundsAmountInput) {
        fundsAmountInput.addEventListener('input', () => {
            fundsAmountInput.classList.remove('input-error');
        });
    }

    function renderEmployees() {
        employeeListEl.innerHTML = '';

        if (!state.employees.length) {
            const empty = document.createElement('div');
            empty.className = 'employee-empty';
            empty.textContent = 'No employees yet.';
            employeeListEl.appendChild(empty);
            return;
        }

        state.employees.forEach(emp => {
            const row = document.createElement('div');
            row.className = 'employee-row';

            const info = document.createElement('div');
            info.className = 'employee-info';

            const name = document.createElement('div');
            name.className = 'employee-name';
            name.textContent = emp.name;

            const dutyDot = document.createElement('span');
            dutyDot.className = `duty-dot ${emp.onduty ? 'on' : 'off'}`;
            dutyDot.title = emp.onduty ? 'On duty' : 'Off duty';
            name.appendChild(dutyDot);

            const grade = document.createElement('div');
            grade.className = 'employee-grade';
            grade.textContent = emp.gradeName || `Grade ${emp.grade}`;

            info.appendChild(name);
            info.appendChild(grade);

            const actions = document.createElement('div');
            actions.className = 'employee-actions';

            const demoteBtn = document.createElement('button');
            demoteBtn.className = 'emp-btn emp-demote';
            demoteBtn.textContent = '▼';
            demoteBtn.title = 'Demote';
            demoteBtn.disabled = emp.grade <= 0;
            demoteBtn.addEventListener('click', () => runAction('bossDemote', { citizenid: emp.citizenid }));

            const promoteBtn = document.createElement('button');
            promoteBtn.className = 'emp-btn emp-promote';
            promoteBtn.textContent = '▲';
            promoteBtn.title = 'Promote';
            promoteBtn.disabled = emp.grade >= state.maxGrade;
            promoteBtn.addEventListener('click', () => runAction('bossPromote', { citizenid: emp.citizenid }));

            const fireBtn = document.createElement('button');
            fireBtn.className = 'emp-btn emp-fire';
            fireBtn.textContent = 'Fire';
            fireBtn.addEventListener('click', () => {
                if (confirm(`Fire ${emp.name}?`)) {
                    runAction('bossFire', { citizenid: emp.citizenid });
                }
            });

            actions.appendChild(demoteBtn);
            actions.appendChild(promoteBtn);
            actions.appendChild(fireBtn);

            row.appendChild(info);
            row.appendChild(actions);
            employeeListEl.appendChild(row);
        });
    }

    /* =========================================================
       STOCK TAB - Storage & Fridge ingredient counts
       ========================================================= */

    function showStockError(msg) {
        if (!stockErrorEl) return;
        stockErrorEl.textContent = msg || '';
        stockErrorEl.classList.toggle('visible', !!msg);
    }

    function renderStock() {
        if (!stockListEl) return;
        stockListEl.innerHTML = '';

        const items = state.stock.items || [];

        if (!items.length) {
            const empty = document.createElement('div');
            empty.className = 'stock-empty';
            empty.textContent = 'No cooking ingredients configured.';
            stockListEl.appendChild(empty);
            return;
        }

        items.forEach(row => {
            const rowEl = document.createElement('div');
            rowEl.className = 'stock-row';

            const nameEl = document.createElement('div');
            nameEl.className = 'stock-item-name';
            nameEl.textContent = row.label;
            rowEl.appendChild(nameEl);

            const storageCount = (row.counts && row.counts.storage) || 0;
            const fridgeCount = (row.counts && row.counts.fridge) || 0;
            const total = typeof row.total === 'number' ? row.total : storageCount + fridgeCount;

            const storageEl = document.createElement('div');
            storageEl.className = `stock-count${storageCount === 0 ? ' zero' : ''}`;
            storageEl.textContent = storageCount;
            rowEl.appendChild(storageEl);

            const fridgeEl = document.createElement('div');
            fridgeEl.className = `stock-count${fridgeCount === 0 ? ' zero' : ''}`;
            fridgeEl.textContent = fridgeCount;
            rowEl.appendChild(fridgeEl);

            const totalEl = document.createElement('div');
            totalEl.className = `stock-count total${total === 0 ? ' low' : ''}`;
            totalEl.textContent = total;
            rowEl.appendChild(totalEl);

            stockListEl.appendChild(rowEl);
        });
    }

    if (stockRefreshBtn) {
        stockRefreshBtn.addEventListener('click', async () => {
            showStockError('');
            stockRefreshBtn.disabled = true;
            const payload = await nuiPost('bossRefreshStock');
            stockRefreshBtn.disabled = false;

            if (!payload || !payload.ok) {
                showStockError((payload && payload.error) || 'Failed to refresh stock.');
                return;
            }

            applyPayload(payload);
            if (stockUpdatedAtEl) {
                stockUpdatedAtEl.textContent = `Updated ${new Date().toLocaleTimeString([], { hour: 'numeric', minute: '2-digit' })}`;
            }
        });
    }

    /* =========================================================
       ORDERS TAB - supply ordering
       ========================================================= */

    function renderOrderCategories() {
        orderCategoryTabsEl.innerHTML = '';
        state.supplyMenu.forEach((cat, index) => {
            const btn = document.createElement('button');
            btn.className = 'category-tab' + (index === activeOrderCategory ? ' active' : '');
            btn.textContent = cat.category;
            btn.addEventListener('click', () => {
                activeOrderCategory = index;
                renderOrderCategories();
                renderOrderItems();
            });
            orderCategoryTabsEl.appendChild(btn);
        });
    }

    function isOrderingLocked() {
        return !!(state.activeSupplyOrder && state.activeSupplyOrder.id);
    }

    function renderOrderItems() {
        orderItemGridEl.innerHTML = '';
        const cat = state.supplyMenu[activeOrderCategory];
        if (!cat) return;

        cat.items.forEach(def => {
            const card = document.createElement('div');
            card.className = 'item-card';

            const thumb = document.createElement('div');
            thumb.className = 'item-thumb item-thumb-fallback';
            thumb.style.width = '64px';
            thumb.style.height = '64px';
            thumb.textContent = '📦';

            const name = document.createElement('div');
            name.className = 'item-name';
            name.textContent = def.label;

            const price = document.createElement('div');
            price.className = 'item-price';
            price.textContent = `${money(def.price)} / unit (${def.amount}x ${def.label})`;

            const addBtn = document.createElement('button');
            addBtn.className = 'item-add';
            addBtn.textContent = 'Add';
            addBtn.disabled = isOrderingLocked();
            addBtn.addEventListener('click', () => addToOrderCart(def));

            card.appendChild(thumb);
            card.appendChild(name);
            card.appendChild(price);
            card.appendChild(addBtn);
            orderItemGridEl.appendChild(card);
        });
    }

    function addToOrderCart(def) {
        if (isOrderingLocked()) return;
        if (!orderCart[def.item]) {
            orderCart[def.item] = { item: def.item, label: def.label, price: def.price, qty: 0 };
        }
        orderCart[def.item].qty += 1;
        renderOrderCart();
    }

    function changeOrderQty(itemCode, delta) {
        const entry = orderCart[itemCode];
        if (!entry) return;
        entry.qty += delta;
        if (entry.qty <= 0) delete orderCart[itemCode];
        renderOrderCart();
    }

    function renderOrderCart() {
        const entries = Object.values(orderCart);
        orderCartItemsEl.innerHTML = '';

        if (entries.length === 0) {
            const empty = document.createElement('div');
            empty.className = 'cart-empty';
            empty.textContent = 'No items selected.';
            orderCartItemsEl.appendChild(empty);
        } else {
            entries.forEach(entry => {
                const row = document.createElement('div');
                row.className = 'cart-row';

                const info = document.createElement('div');
                info.className = 'cart-row-info';

                const nameEl = document.createElement('div');
                nameEl.className = 'cart-row-name';
                nameEl.textContent = entry.label;

                const priceEl = document.createElement('div');
                priceEl.className = 'cart-row-price';
                priceEl.textContent = `${money(entry.price)} each`;

                info.appendChild(nameEl);
                info.appendChild(priceEl);

                const controls = document.createElement('div');
                controls.className = 'qty-controls';

                const minusBtn = document.createElement('button');
                minusBtn.className = 'qty-btn';
                minusBtn.textContent = '-';
                minusBtn.disabled = isOrderingLocked();
                minusBtn.addEventListener('click', () => changeOrderQty(entry.item, -1));

                const qtyEl = document.createElement('div');
                qtyEl.className = 'qty-value';
                qtyEl.textContent = entry.qty;

                const plusBtn = document.createElement('button');
                plusBtn.className = 'qty-btn';
                plusBtn.textContent = '+';
                plusBtn.disabled = isOrderingLocked();
                plusBtn.addEventListener('click', () => changeOrderQty(entry.item, 1));

                controls.appendChild(minusBtn);
                controls.appendChild(qtyEl);
                controls.appendChild(plusBtn);

                row.appendChild(info);
                row.appendChild(controls);
                orderCartItemsEl.appendChild(row);
            });
        }

        const total = entries.reduce((sum, e) => sum + (e.price * e.qty), 0);
        orderCartTotalEl.textContent = money(total);
        orderSubmitBtn.disabled = entries.length === 0 || isOrderingLocked();
    }

    function renderSupplyStatusBanner() {
        const order = state.activeSupplyOrder;
        supplyStatusBannerEl.classList.remove('status-claimed', 'status-finished');

        if (!order || !order.id) {
            supplyStatusBannerEl.classList.remove('visible');
            supplyStatusBannerEl.textContent = '';
            return;
        }

        supplyStatusBannerEl.classList.add('visible');
        if (order.claimed) {
            supplyStatusBannerEl.classList.add('status-claimed');
            supplyStatusBannerEl.textContent = `Order #${order.id} claimed - van is en route to Burgershot.`;
        } else {
            supplyStatusBannerEl.textContent = `Order #${order.id} placed - waiting for someone to pick up the van.`;
        }
    }

    function renderOrders() {
        renderOrderCategories();
        renderOrderItems();
        renderOrderCart();
        renderSupplyStatusBanner();
    }

    function resetOrderCart() {
        orderCart = {};
        renderOrderCart();
    }

    orderClearBtn.addEventListener('click', resetOrderCart);

    orderSubmitBtn.addEventListener('click', async () => {
        const entries = Object.values(orderCart);
        if (entries.length === 0 || isOrderingLocked()) return;

        const cart = entries.map(e => ({ item: e.item, qty: e.qty }));

        orderSubmitBtn.disabled = true;
        const payload = await nuiPost('bossOrderSupplies', { cart });

        if (payload && payload.ok) {
            resetOrderCart();
            state.activeSupplyOrder = { id: payload.orderId, claimed: false };
            renderSupplyStatusBanner();
        } else {
            showError((payload && payload.error) || 'Failed to place supply order.');
            orderSubmitBtn.disabled = entries.length === 0;
        }
    });

    // Live updates pushed from cl_supplyorder.lua while the menu is open
    function handleSupplyOrderUpdate(data) {
        if (!data || !data.orderId) return;

        if (data.status === 'ready') {
            state.activeSupplyOrder = { id: data.orderId, claimed: false };
        } else if (data.status === 'claimed') {
            if (state.activeSupplyOrder && state.activeSupplyOrder.id === data.orderId) {
                state.activeSupplyOrder.claimed = true;
            } else {
                state.activeSupplyOrder = { id: data.orderId, claimed: true };
            }
        } else if (data.status === 'finished') {
            state.activeSupplyOrder = null;
        }

        renderSupplyStatusBanner();
        renderOrderItems();
        renderOrderCart();
    }

    async function runAction(endpoint, data) {
        showError('');
        const payload = await nuiPost(endpoint, data);
        if (!payload || !payload.ok) {
            showError((payload && payload.error) || 'Action failed.');
        }
        applyPayload(payload);
        return payload;
    }

    hireBtn.addEventListener('click', async () => {
        const serverId = parseInt(hireInput.value, 10);
        if (!serverId || serverId <= 0) {
            showError('Enter a valid server ID.');
            return;
        }
        const payload = await runAction('bossHire', { serverId });
        if (payload && payload.ok) hireInput.value = '';
    });

    function closeBossMenu() {
        bossmenu.classList.add('hidden');
        nuiPost('closeBossMenu');
    }

    closeBtn.addEventListener('click', closeBossMenu);

    document.addEventListener('keyup', (e) => {
        if (e.key === 'Escape' && !bossmenu.classList.contains('hidden')) {
            closeBossMenu();
        }
    });

    function openBossMenu(data) {
        state = {
            employees: data.employees || [],
            grades: data.grades || [],
            maxGrade: data.maxGrade || 0,
            balance: data.balance || 0,
            transactions: data.transactions || [],
            supplyMenu: data.supplyMenu || [],
            activeSupplyOrder: data.activeSupplyOrder || null,
            stock: data.stock || { containers: [], items: [] },
        };
        orderCart = {};
        activeOrderCategory = 0;
        showError('');
        resetFundsForm();
        switchTab('overview');
        renderOverviewStats();
        renderFinances();
        renderEmployees();
        renderOrders();
        renderStock();
        bossmenu.classList.remove('hidden');
    }

    function closeBossMenuUI() {
        bossmenu.classList.add('hidden');
    }

    window.addEventListener('message', (e) => {
        const data = e.data;
        if (!data || !data.action) return;

        if (data.action === 'openBossMenu') {
            openBossMenu(data);
        } else if (data.action === 'closeBossMenu') {
            closeBossMenuUI();
        } else if (data.action === 'supplyOrderUpdate') {
            handleSupplyOrderUpdate(data);
        }
    });
})();
