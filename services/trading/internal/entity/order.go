package entity

type Order struct {
	ID        int64   `json:"id"`
	UserID    int64   `json:"user_id"`
	Market    string  `json:"market"` // e.g., BTC-USD, ETH-BTC, etc.
	Type      string  `json:"type"`   // e.g., limit, market, stop-loss, etc.
	Side      string  `json:"side"`   // buy or sell
	Quantity  float64 `json:"quantity"`
	Price     float64 `json:"price"`  // Price per unit of cryptocurrency
	Status    string  `json:"status"` // e.g., open, filled, cancelled, etc.
	CreatedAt string  `json:"created_at"`
}
