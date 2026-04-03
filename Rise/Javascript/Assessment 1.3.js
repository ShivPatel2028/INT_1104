async function fetchApiData(url) {
    try {
        const response = await fetch(url);

        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }

        const data = await response.json();
        return data;
    } catch (error) {
        console.error('Unable to fetch API data:', error.message);
        return { error: true, message: error.message };
    }
}

// Example usage
fetchApiData('https://api.example.com/data')
    .then(result => {
        if (result.error) {
            console.log('Something went wrong:', result.message);
        } else {
            console.log('Fetched data:', result);
        }
    });