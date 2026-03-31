function numberProcessor(numbers) {
  // Separate even and odd numbers
  const evenNumbers = numbers.filter(num => num % 2 === 0);
  const oddNumbers = numbers.filter(num => num % 2 !== 0);

  // Calculate sums
  const evenSum = evenNumbers.reduce((sum, num) => sum + num, 0);
  const oddSum = oddNumbers.reduce((sum, num) => sum + num, 0);

  return {
    evenNumbers,
    oddNumbers,
    evenSum,
    oddSum
  };
}

// Example
const result = numberProcessor([1, 2, 3, 4, 5, 6]);

console.log(result);