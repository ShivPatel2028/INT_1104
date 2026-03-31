function updateUserProfile(user, newCity, profession) {
  // Create a new object using spread operator
  const updatedUser = {
    ...user,
    city: newCity,
    profession: profession
  };

  return updatedUser;
}

// Example
const user = {
  name: "Rahul",
  age: 22,
  city: "Delhi"
};

const newUser = updateUserProfile(user, "Mumbai", "Engineer");

console.log("Original User:", user);     // unchanged
console.log("Updated User:", newUser);   // new object