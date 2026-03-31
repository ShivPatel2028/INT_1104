const products = [
  { name: "Laptop", price: 50000 },
  { name: "Mouse", price: 500 },
  { name: "Phone", price: 15000 },
  { name: "Keyboard", price: 800 }
];

const result = products
  .filter(product => product.price > 1000) // filter condition
  .map(product => ({
    ...product,
    discountedPrice: product.price * 0.9 // 10% discount
  }));

console.log(result);