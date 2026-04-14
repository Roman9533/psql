BEGIN;

INSERT INTO orders (client_id, status)
VALUES (1, 'Принят')
RETURNING id INTO new_order_id;

INSERT INTO order_items (order_id, item_id, quantity)
VALUES
    (new_order_id, 1, 2),  -- 'Маргарита'
    (new_order_id, 2, 1),  -- 'Пепперони'
    (new_order_id, 3, 1);  -- 'Четыре сыра'

COMMIT;

BEGIN;

INSERT INTO orders (client_id, status)
VALUES (5, 'Принят')
RETURNING id INTO new_order_id;

BEGIN
    INSERT INTO order_items (order_id, item_id, quantity)
    VALUES (new_order_id, 8, 0);
EXCEPTION
    WHEN others THEN
	ROLLBACK;
        RAISE;
		END;

COMMIT;

CREATE INDEX idx_customers_full_name ON customers (full_name);