const form = document.getElementById('searchForm');
const cityInput = document.getElementById('cityInput');
const weatherDisplay = document.getElementById('weatherDisplay');

// Your actual API key
const apiKey = '1d7d85aa58a02d6831ac07c52d9d4522';

// Update background based on weather condition
function updateBackground(weatherCondition) {
    const body = document.body;
    if (weatherCondition.includes('rain')) {
        body.style.background = 'linear-gradient(to bottom, #4e54c8, #8f94fb)';
    } else if (weatherCondition.includes('cloud')) {
        body.style.background = 'linear-gradient(to bottom, #d3d3d3, #7f8c8d)';
    } else if (weatherCondition.includes('clear')) {
        body.style.background = 'linear-gradient(to bottom, #56ccf2, #2f80ed)';
    } else if (weatherCondition.includes('snow')) {
        body.style.background = 'linear-gradient(to bottom, #e0eafc, #cfdef3)';
    } else {
        body.style.background = 'linear-gradient(to bottom, #f5f7fa, #c3cfe2)';
    }
}

// Get weather data and display
form.addEventListener('submit', async (e) => {
    e.preventDefault();
    const city = cityInput.value;
    const apiUrl = `https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${apiKey}&units=metric`;

    try {
        const response = await fetch(apiUrl);
        if (!response.ok) throw new Error('City not found');
        const data = await response.json();
        displayWeather(data);
        displayForecast(data);
    } catch (error) {
        weatherDisplay.innerHTML = `<p>${error.message}</p>`;
    }
});

// Display weather data
function displayWeather(data) {
    const weatherCondition = data.weather[0].description.toLowerCase();
    updateBackground(weatherCondition);

    const weatherIcon = `https://openweathermap.org/img/wn/${data.weather[0].icon}@2x.png`;

    weatherDisplay.innerHTML = `
        <h2>${data.name}, ${data.sys.country}</h2>
        <img src="${weatherIcon}" alt="${weatherCondition}" />
        <p><strong>Temperature:</strong> ${data.main.temp}°C</p>
        <p><strong>Weather:</strong> ${data.weather[0].description}</p>
        <p><strong>Humidity:</strong> ${data.main.humidity}%</p>
    `;
}

// Fetch and display 7-day forecast
async function fetchForecast(lat, lon) {
    const forecastUrl = `https://api.openweathermap.org/data/2.5/onecall?lat=${lat}&lon=${lon}&exclude=current,minutely,hourly,alerts&units=metric&appid=${apiKey}`;
    const response = await fetch(forecastUrl);
    return await response.json();
}

async function displayForecast(data) {
    const forecast = await fetchForecast(data.coord.lat, data.coord.lon);
    const forecastDisplay = document.createElement('div');
    forecastDisplay.classList.add('forecast');

    forecast.daily.slice(1, 8).forEach(day => {
        const date = new Date(day.dt * 1000).toLocaleDateString('en-US', { weekday: 'short' });
        const icon = `https://openweathermap.org/img/wn/${day.weather[0].icon}@2x.png`;
        const temp = day.temp.day;

        forecastDisplay.innerHTML += `
            <div class="forecast-item">
                <p>${date}</p>
                <img src="${icon}" alt="${day.weather[0].description}" />
                <p>${temp}°C</p>
            </div>
        `;
    });

    document.getElementById('weatherDisplay').appendChild(forecastDisplay);
}

// Get weather by current location
navigator.geolocation.getCurrentPosition(async (position) => {
    const { latitude, longitude } = position.coords;
    const apiUrl = `https://api.openweathermap.org/data/2.5/weather?lat=${latitude}&lon=${longitude}&appid=${apiKey}&units=metric`;
    const response = await fetch(apiUrl);
    const data = await response.json();
    displayWeather(data);
});
