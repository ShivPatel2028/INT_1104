const orders = [
  {
    id: 1,
    items: [
      { name: "Shirt", price: 500, quantity: 2 },
      { name: "Shoes", price: 1000, quantity: 1 }
    ]
  },
  {
    id: 2,
    items: [
      { name: "Cap", price: 200, quantity: 3 },
      { name: "Watch", price: 1500, quantity: 1 }
    ]
  }
];

// Process orders
const processedOrders = orders.map(order => {
  const totalAmount = order.items.reduce(
    (sum, item) => sum + item.price * item.quantity, 0
  );

  const totalQuantity = order.items.reduce(
    (sum, item) => sum + item.quantity, 0
  );

  return {
    ...order,
    totalAmount,
    totalQuantity
  };
});

console.log(processedOrders);