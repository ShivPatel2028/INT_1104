//Suresh and Ramesh want to compare their BMI (Body Mass Index).

let sureshMass = 70;      // mass in kg
let sureshHeight = 1.75;  // height in meters

let rameshMass = 80;      // mass in kg
let rameshHeight = 1.8;   // height in meters


// Step 2: Calculate BMI using the formula
// BMI = mass / (height * height)

let sureshBMI = sureshMass / (sureshHeight * sureshHeight);
let rameshBMI = rameshMass / (rameshHeight * rameshHeight);


// Step 3: Compare BMI values

let markHigherBMI = sureshBMI > rameshBMI;


// Output the results

console.log("Suresh BMI:", sureshBMI);
console.log("Ramesh BMI:", rameshBMI);
console.log("Does Suresh have higher BMI than Ramesh?", markHigherBMI);

