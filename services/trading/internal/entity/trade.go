package entity

type Trade struct {
	ID        int64   `json:"id"`
	OrderID   int64   `json:"order_id"`
	UserID    int64   `json:"user_id"`
	Market    string  `json:"market"`
	Quantity  float64 `json:"quantity"`
	Price     float64 `json:"price"`
	Fee       float64 `json:"fee"`
	Side      string  `json:"side"`
	Timestamp string  `json:"timestamp"` // Timestamp of the trade execution
}
