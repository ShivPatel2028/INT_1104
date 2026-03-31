2.

function cartAnalyzer(...items) {
  let totalAmount = 0;
  let totalQuantity = 0;

  items.forEach(item => {
    totalAmount += item.price * item.quantity;
    totalQuantity += item.quantity;
  });

  return {
    totalAmount: totalAmount,
    totalQuantity: totalQuantity
  };
}

// Example usage
const result = cartAnalyzer(
  { name: "Shirt", price: 500, quantity: 2 },
  { name: "Shoes", price: 1000, quantity: 1 },
  { name: "Cap", price: 200, quantity: 3 }
);

console.log(result);