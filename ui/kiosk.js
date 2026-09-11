(function () {
    const kiosk = document.getElementById('kiosk');
    const brandSub = document.getElementById('brandSub');
    const statusClock = document.getElementById('statusClock');
    const categoryTabs = document.getElementById('categoryTabs');
    const itemGrid = document.getElementById('itemGrid');
    const cartItemsEl = document.getElementById('cartItems');
    const cartTotalEl = document.getElementById('cartTotal');
    const printBtn = document.getElementById('printBtn');
    const clearBtn = document.getElementById('clearBtn');
    const closeBtn = document.getElementById('closeBtn');
    const customerIdInput = document.getElementById('customerId');

    let menu = [];
    let cart = {}; // key: label, value: { label, price, qty }
    let activeCategory = 0;

    function getResourceName() {
        return (typeof GetParentResourceName === 'function')
            ? GetParentResourceName()
            : 'bd-burgershot';
    }

    function nuiFetch(endpoint, data) {
        fetch(`https://${getResourceName()}/${endpoint}`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json; charset=UTF-8' },
            body: JSON.stringify(data || {})
        }).catch(() => {});
    }

    function money(n) {
        return `$${Number(n).toFixed(0)}`;
    }

    function updateClock() {
        if (!statusClock) return;
        statusClock.textContent = new Date().toLocaleTimeString([], { hour: 'numeric', minute: '2-digit' });
    }
    updateClock();
    setInterval(updateClock, 30000);

    function buildThumb(image, size) {
        const wrap = document.createElement('div');
        wrap.className = 'item-thumb';
        wrap.style.width = size + 'px';
        wrap.style.height = size + 'px';

        if (image) {
            const img = document.createElement('img');
            img.src = image;
            img.alt = '';
            img.onerror = () => {
                img.remove();
                wrap.classList.add('item-thumb-fallback');
                wrap.textContent = '🍔';
            };
            wrap.appendChild(img);
        } else {
            wrap.classList.add('item-thumb-fallback');
            wrap.textContent = '🍔';
        }

        return wrap;
    }

    function renderCategories() {
        categoryTabs.innerHTML = '';
        menu.forEach((cat, index) => {
            const btn = document.createElement('button');
            btn.className = 'category-tab' + (index === activeCategory ? ' active' : '');
            btn.textContent = cat.category;
            btn.addEventListener('click', () => {
                activeCategory = index;
                renderCategories();
                renderItems();
            });
            categoryTabs.appendChild(btn);
        });
    }

    function renderItems() {
        itemGrid.innerHTML = '';
        const cat = menu[activeCategory];
        if (!cat) return;

        cat.items.forEach(item => {
            const card = document.createElement('div');
            card.className = 'item-card';

            const thumb = buildThumb(item.image, 64);

            const name = document.createElement('div');
            name.className = 'item-name';
            name.textContent = item.label;

            const price = document.createElement('div');
            price.className = 'item-price';
            price.textContent = money(item.price);

            const addBtn = document.createElement('button');
            addBtn.className = 'item-add';
            addBtn.textContent = 'Add';
            addBtn.addEventListener('click', () => addToCart(item));

            card.appendChild(thumb);
            card.appendChild(name);
            card.appendChild(price);
            card.appendChild(addBtn);
            itemGrid.appendChild(card);
        });
    }

    function addToCart(item) {
        if (!cart[item.label]) {
            cart[item.label] = { label: item.label, price: item.price, qty: 0, image: item.image };
        }
        cart[item.label].qty += 1;
        renderCart();
    }

    function changeQty(label, delta) {
        const entry = cart[label];
        if (!entry) return;
        entry.qty += delta;
        if (entry.qty <= 0) {
            delete cart[label];
        }
        renderCart();
    }

    function renderCart() {
        const entries = Object.values(cart);
        cartItemsEl.innerHTML = '';

        if (entries.length === 0) {
            const empty = document.createElement('div');
            empty.className = 'cart-empty';
            empty.textContent = 'No items yet. Tap something tasty!';
            cartItemsEl.appendChild(empty);
        } else {
            entries.forEach(entry => {
                const row = document.createElement('div');
                row.className = 'cart-row';

                const thumb = buildThumb(entry.image, 32);

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
                minusBtn.addEventListener('click', () => changeQty(entry.label, -1));

                const qtyEl = document.createElement('div');
                qtyEl.className = 'qty-value';
                qtyEl.textContent = entry.qty;

                const plusBtn = document.createElement('button');
                plusBtn.className = 'qty-btn';
                plusBtn.textContent = '+';
                plusBtn.addEventListener('click', () => changeQty(entry.label, 1));

                controls.appendChild(minusBtn);
                controls.appendChild(qtyEl);
                controls.appendChild(plusBtn);

                row.appendChild(thumb);
                row.appendChild(info);
                row.appendChild(controls);
                cartItemsEl.appendChild(row);
            });
        }

        const total = entries.reduce((sum, e) => sum + (e.price * e.qty), 0);
        cartTotalEl.textContent = money(total);
        printBtn.disabled = entries.length === 0;
    }

    function resetCart() {
        cart = {};
        renderCart();
        if (customerIdInput) {
            customerIdInput.value = '';
            customerIdInput.classList.remove('input-error');
        }
    }

    function openKiosk(data) {
        menu = data.menu || [];
        activeCategory = 0;
        resetCart();
        renderCategories();
        renderItems();
        if (brandSub) {
            brandSub.textContent = data.playerName ? `${data.playerName}'s Register` : 'Employee Register';
        }
        kiosk.classList.remove('hidden');
    }

    function closeKiosk() {
        kiosk.classList.add('hidden');
    }

    window.addEventListener('message', (e) => {
        const data = e.data;
        if (!data || !data.action) return;

        if (data.action === 'openKiosk') {
            openKiosk(data);
        } else if (data.action === 'closeKiosk') {
            closeKiosk();
        }
    });

    document.addEventListener('keyup', (e) => {
        if (e.key === 'Escape') {
            closeKiosk();
            nuiFetch('closeKiosk');
        }
    });

    closeBtn.addEventListener('click', () => {
        closeKiosk();
        nuiFetch('closeKiosk');
    });

    clearBtn.addEventListener('click', () => {
        resetCart();
    });

    if (customerIdInput) {
        customerIdInput.addEventListener('input', () => {
            customerIdInput.classList.remove('input-error');
        });
    }

    printBtn.addEventListener('click', () => {
        const entries = Object.values(cart);
        if (entries.length === 0) return;

        const customerId = parseInt(customerIdInput.value, 10);
        if (!customerId || customerId <= 0) {
            customerIdInput.classList.add('input-error');
            customerIdInput.focus();
            return;
        }

        const total = entries.reduce((sum, e) => sum + (e.price * e.qty), 0);

        closeKiosk();
        nuiFetch('submitOrder', { items: entries, total: total, customerId: customerId });
    });
})();