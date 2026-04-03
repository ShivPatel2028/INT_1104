// Human-friendly flatten for nested arrays
function flattenArray(input) {
  const result = [];

  function recurse(value) {
    if (Array.isArray(value)) {
      for (const item of value) {
        recurse(item);
      }
    } else {
      result.push(value);
    }
  }

  recurse(input);
  return result;
}


const nested = [1, [2, [3, 4]], 5];
const flat = flattenArray(nested);
console.log('Nested:', nested); 
console.log('Flattened:', flat); 


console.log(flattenArray([1, [2, [3]]]));
