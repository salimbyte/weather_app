import 'package:flutter/material.dart';
import 'package:flutter/services.dart';  // Import services
import 'package:weather_app/aboutme.dart';
import 'package:weather_app/WeatherResultPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _controller = TextEditingController();
  List<Map<String, String>> suggestions = [];
  bool showSuggestions = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    // Set the status bar color to blue
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.green, // Blue status bar
        statusBarIconBrightness: Brightness.light, // Light status bar icons
      ),
    );

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green, // AppBar color
          elevation: 0, // Remove the shadow by setting elevation to 0
          title: const Text('Weather App'),
          actions: [
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutMePage()),
                );
              },
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildGreetingText(),
              const SizedBox(height: 20),
              _buildSearchWidget(),
              const SizedBox(height: 20),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.green,
          padding: const EdgeInsets.all(10),
          child: const Text(
            'Salim Suleiman U1/21/CSC/0796',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  Widget _buildGreetingText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Welcome to the Weather App!",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText: 'Search for a city...',
                  prefixIcon: const Icon(Icons.search, color: Colors.orange),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onChanged: (value) {
                  _onSearchChanged(value);
                },
                onSubmitted: (value) {
                  _onCitySearch(value);
                },
              ),
            ),
            const SizedBox(width: 7),
            Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: isLoading
                  ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ) // Show spinner when loading
                  : IconButton(
                icon: const Icon(Icons.my_location, color: Colors.white),
                onPressed: () {
                  if (_controller.text.isEmpty) {
                    _showEmptySearchAlert();
                  } else {
                    _onCitySearch(_controller.text);
                  }
                },
                tooltip: "Search for city",
              ),
            ),
          ],
        ),
        const SizedBox(height: 8), // Add some space between the TextField and the instruction
        Text(
          "Start typing the name of a city to check its weather.",
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            fontStyle: FontStyle.italic,
          ),
        ),
        if (showSuggestions && _controller.text.isNotEmpty)
          Container(
            padding: const EdgeInsets.only(top: 8),
            height: 150,
            child: ListView.builder(
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.location_on),
                  title: Text(suggestions[index]['location'] ?? ''),
                  subtitle: Text(suggestions[index]['country'] ?? ''),
                  onTap: () {
                    _controller.text = suggestions[index]['location'] ?? '';
                    _navigateToWeatherDetailPage(suggestions[index]['location'] ?? '');
                    setState(() {
                      showSuggestions = false;
                    });
                  },
                );
              },
            ),
          ),
      ],
    );
  }

  void _navigateToWeatherDetailPage(String location) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WeatherDetailPage(location: location),
      ),
    );
  }

  void _onCitySearch(String query) {
    if (query.isEmpty) {
      _showEmptySearchAlert();
      return;
    }



    _navigateToWeatherDetailPage(query);
  }

  void _showEmptySearchAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("No City Entered"),
          content: const Text("Please enter a city to search for its weather."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _onSearchChanged(String query) {
    if (query.isEmpty) {
      setState(() {
        showSuggestions = false;
      });
      return;
    }

    setState(() {
      showSuggestions = true;
      suggestions = [
        {"location": "Abuja", "country": "Nigeria"},
        {"location": "Lagos", "country": "Nigeria"},
        {"location": "Port Harcourt", "country": "Nigeria"},
        {"location": "Kano", "country": "Nigeria"},
        {"location": "Ibadan", "country": "Nigeria"},
        {"location": "Kaduna", "country": "Nigeria"},
        {"location": "Benin City", "country": "Nigeria"},
        {"location": "Enugu", "country": "Nigeria"},
        {"location": "Maiduguri", "country": "Nigeria"},
        {"location": "Abeokuta", "country": "Nigeria"},
        {"location": "Calabar", "country": "Nigeria"},
        {"location": "Ilorin", "country": "Nigeria"},
        {"location": "Ogun", "country": "Nigeria"},
        {"location": "Oyo", "country": "Nigeria"},
        {"location": "Ekiti", "country": "Nigeria"},
        {"location": "Ondo", "country": "Nigeria"},
        {"location": "Delta", "country": "Nigeria"},
        {"location": "Anambra", "country": "Nigeria"},
        {"location": "Abia", "country": "Nigeria"},
        {"location": "Imo", "country": "Nigeria"},
        {"location": "Rivers", "country": "Nigeria"},
        {"location": "Bauchi", "country": "Nigeria"},
        {"location": "Yobe", "country": "Nigeria"},
        {"location": "Jigawa", "country": "Nigeria"},
        {"location": "Sokoto", "country": "Nigeria"},
        {"location": "Zamfara", "country": "Nigeria"},
        {"location": "Adamawa", "country": "Nigeria"},
        {"location": "Taraba", "country": "Nigeria"},
        {"location": "Niger", "country": "Nigeria"},
        {"location": "Kogi", "country": "Nigeria"},
        {"location": "Kebbi", "country": "Nigeria"},
        {"location": "Ekiti", "country": "Nigeria"},
        {"location": "Gombe", "country": "Nigeria"},
        {"location": "Lagos Mainland", "country": "Nigeria"},
        {"location": "Victoria Island", "country": "Nigeria"},
        {"location": "Lekki", "country": "Nigeria"},
        {"location": "Surulere", "country": "Nigeria"},
        {"location": "Ikorodu", "country": "Nigeria"},
        {"location": "Ikeja", "country": "Nigeria"},
        {"location": "Badagry", "country": "Nigeria"},
        {"location": "Alimosho", "country": "Nigeria"},
        {"location": "Mushin", "country": "Nigeria"},
        {"location": "United Kingdom", "country": "UK"},
        {"location": "London", "country": "UK"},
        {"location": "Manchester", "country": "UK"},
        {"location": "Birmingham", "country": "UK"},
        {"location": "Leeds", "country": "UK"},
        {"location": "Edinburgh", "country": "UK"},
        {"location": "Glasgow", "country": "UK"},
        {"location": "Liverpool", "country": "UK"},
        {"location": "Bristol", "country": "UK"},
        {"location": "Sheffield", "country": "UK"},
        {"location": "Tokyo", "country": "Japan"},
        {"location": "Osaka", "country": "Japan"},
        {"location": "Kyoto", "country": "Japan"},
        {"location": "Hiroshima", "country": "Japan"},
        {"location": "Sapporo", "country": "Japan"},
        {"location": "Yokohama", "country": "Japan"},
        {"location": "Paris", "country": "France"},
        {"location": "Marseille", "country": "France"},
        {"location": "Lyon", "country": "France"},
        {"location": "Nice", "country": "France"},
        {"location": "Berlin", "country": "Germany"},
        {"location": "Hamburg", "country": "Germany"},
        {"location": "Munich", "country": "Germany"},
        {"location": "Cologne", "country": "Germany"},
        {"location": "Los Angeles", "country": "USA"},
        {"location": "New York", "country": "USA"},
        {"location": "Chicago", "country": "USA"},
        {"location": "San Francisco", "country": "USA"},
        {"location": "Miami", "country": "USA"},
        {"location": "Washington D.C.", "country": "USA"},
        {"location": "Toronto", "country": "Canada"},
        {"location": "Vancouver", "country": "Canada"},
        {"location": "Montreal", "country": "Canada"},
        {"location": "Ottawa", "country": "Canada"},
        {"location": "Sydney", "country": "Australia"},
        {"location": "Melbourne", "country": "Australia"},
        {"location": "Brisbane", "country": "Australia"},
        {"location": "Perth", "country": "Australia"},
        {"location": "Cairo", "country": "Egypt"},
        {"location": "Lagos", "country": "Nigeria"},
        {"location": "Katsina", "country": "Nigeria"},
        {"location": "Daura", "country": "Nigeria"},
        {"location": "Funtua", "country": "Nigeria"},
        {"location": "Malumfashi", "country": "Nigeria"},
        {"location": "Zango", "country": "Nigeria"},
        {"location": "Kankara", "country": "Nigeria"},
        {"location": "Dutsinma", "country": "Nigeria"},
        {"location": "Mashi", "country": "Nigeria"},
        {"location": "Bakori", "country": "Nigeria"},
        {"location": "Batagarawa", "country": "Nigeria"},
        {"location": "Jibia", "country": "Nigeria"},
        {"location": "Kusada", "country": "Nigeria"},
        {"location": "Kazaure", "country": "Nigeria"},
        {"location": "Kafur", "country": "Nigeria"},
        {"location": "Kurfi", "country": "Nigeria"},
        {"location": "Rimi", "country": "Nigeria"},
        {"location": "Sabuwa", "country": "Nigeria"},
        {"location": "Sandamu", "country": "Nigeria"},
        {"location": "Zaria", "country": "Nigeria"},
        {"location": "Dandume", "country": "Nigeria"},
        {"location": "Ingawa", "country": "Nigeria"},
        {"location": "Kankia", "country": "Nigeria"},
        {"location": "Mai'adua", "country": "Nigeria"},
        {"location": "Mani", "country": "Nigeria"},
        {"location": "Matazu", "country": "Nigeria"},
        {"location": "Musawa", "country": "Nigeria"},
        {"location": "Sabuwa", "country": "Nigeria"},
        {"location": "Tashar", "country": "Nigeria"},
        {"location": "Katsina Central", "country": "Nigeria"},
        {"location": "Funtua Central", "country": "Nigeria"},
        {"location": "Kafur Central", "country": "Nigeria"},
        {"location": "Beijing", "country": "China"},
        {"location": "Afghanistan", "country": "Afghanistan"},
        {"location": "Algeria", "country": "Algeria"},
        {"location": "Andorra", "country": "Andorra"},
        {"location": "Angola", "country": "Angola"},
        {"location": "Argentina", "country": "Argentina"},
        {"location": "Australia", "country": "Australia"},
        {"location": "Austria", "country": "Austria"},
        {"location": "Bahamas", "country": "Bahamas"},
        {"location": "Bahrain", "country": "Bahrain"},
        {"location": "Bangladesh", "country": "Bangladesh"},
        {"location": "Barbados", "country": "Barbados"},
        {"location": "Belarus", "country": "Belarus"},
        {"location": "Belgium", "country": "Belgium"},
        {"location": "Belize", "country": "Belize"},
        {"location": "Benin", "country": "Benin"},
        {"location": "Bhutan", "country": "Bhutan"},
        {"location": "Bolivia", "country": "Bolivia"},
        {"location": "Bosnia and Herzegovina", "country": "Bosnia and Herzegovina"},
        {"location": "Botswana", "country": "Botswana"},
        {"location": "Brazil", "country": "Brazil"},
        {"location": "Brunei", "country": "Brunei"},
        {"location": "Bulgaria", "country": "Bulgaria"},
        {"location": "Burkina Faso", "country": "Burkina Faso"},
        {"location": "Burundi", "country": "Burundi"},
        {"location": "Cabo Verde", "country": "Cape Verde"},
        {"location": "Cambodia", "country": "Cambodia"},
        {"location": "Cameroon", "country": "Cameroon"},
        {"location": "Canada", "country": "Canada"},
        {"location": "Central African Republic", "country": "Central African Republic"},
        {"location": "Chad", "country": "Chad"},
        {"location": "Chile", "country": "Chile"},
        {"location": "China", "country": "China"},
        {"location": "Colombia", "country": "Colombia"},
        {"location": "Comoros", "country": "Comoros"},
        {"location": "Congo", "country": "Congo"},
        {"location": "Costa Rica", "country": "Costa Rica"},
        {"location": "Croatia", "country": "Croatia"},
        {"location": "Cuba", "country": "Cuba"},
        {"location": "Cyprus", "country": "Cyprus"},
        {"location": "Czech Republic", "country": "Czech Republic"},
        {"location": "Denmark", "country": "Denmark"},
        {"location": "Djibouti", "country": "Djibouti"},
        {"location": "Dominica", "country": "Dominica"},
        {"location": "Dominican Republic", "country": "Dominican Republic"},
        {"location": "Ecuador", "country": "Ecuador"},
        {"location": "Egypt", "country": "Egypt"},
        {"location": "El Salvador", "country": "El Salvador"},
        {"location": "Equatorial Guinea", "country": "Equatorial Guinea"},
        {"location": "Eritrea", "country": "Eritrea"},
        {"location": "Estonia", "country": "Estonia"},
        {"location": "Eswatini", "country": "Eswatini"},
        {"location": "Ethiopia", "country": "Ethiopia"},
        {"location": "Fiji", "country": "Fiji"},
        {"location": "Finland", "country": "Finland"},
        {"location": "France", "country": "France"},
        {"location": "Gabon", "country": "Gabon"},
        {"location": "Gambia", "country": "Gambia"},
        {"location": "Georgia", "country": "Georgia"},
        {"location": "Germany", "country": "Germany"},
        {"location": "Ghana", "country": "Ghana"},
        {"location": "Greece", "country": "Greece"},
        {"location": "Grenada", "country": "Grenada"},
        {"location": "Guatemala", "country": "Guatemala"},
        {"location": "Guinea", "country": "Guinea"},
        {"location": "Guinea-Bissau", "country": "Guinea-Bissau"},
        {"location": "Guyana", "country": "Guyana"},
        {"location": "Haiti", "country": "Haiti"},
        {"location": "Honduras", "country": "Honduras"},
        {"location": "Hungary", "country": "Hungary"},
        {"location": "Iceland", "country": "Iceland"},
        {"location": "India", "country": "India"},
        {"location": "Indonesia", "country": "Indonesia"},
        {"location": "Iran", "country": "Iran"},
        {"location": "Iraq", "country": "Iraq"},
        {"location": "Ireland", "country": "Ireland"},
        {"location": "Israel", "country": "Israel"},
        {"location": "Italy", "country": "Italy"},
        {"location": "Ivory Coast", "country": "Ivory Coast"},
        {"location": "Jamaica", "country": "Jamaica"},
        {"location": "Japan", "country": "Japan"},
        {"location": "Jordan", "country": "Jordan"},
        {"location": "Kazakhstan", "country": "Kazakhstan"},
        {"location": "Kenya", "country": "Kenya"},
        {"location": "Kiribati", "country": "Kiribati"},
        {"location": "Korea", "country": "Korea"},
        {"location": "Kuwait", "country": "Kuwait"},
        {"location": "Kyrgyzstan", "country": "Kyrgyzstan"},
        {"location": "Laos", "country": "Laos"},
        {"location": "Latvia", "country": "Latvia"},
        {"location": "Lebanon", "country": "Lebanon"},
        {"location": "Lesotho", "country": "Lesotho"},
        {"location": "Liberia", "country": "Liberia"},
        {"location": "Libya", "country": "Libya"},
        {"location": "Liechtenstein", "country": "Liechtenstein"},
        {"location": "Lithuania", "country": "Lithuania"},
        {"location": "Luxembourg", "country": "Luxembourg"},
        {"location": "Madagascar", "country": "Madagascar"},
        {"location": "Malawi", "country": "Malawi"},
        {"location": "Malaysia", "country": "Malaysia"},
        {"location": "Maldives", "country": "Maldives"},
        {"location": "Mali", "country": "Mali"},
        {"location": "Malta", "country": "Malta"},
        {"location": "Marshall Islands", "country": "Marshall Islands"},
        {"location": "Mauritania", "country": "Mauritania"},
        {"location": "Mauritius", "country": "Mauritius"},
        {"location": "Mexico", "country": "Mexico"},
        {"location": "Micronesia", "country": "Micronesia"},
        {"location": "Moldova", "country": "Moldova"},
        {"location": "Monaco", "country": "Monaco"},
        {"location": "Mongolia", "country": "Mongolia"},
        {"location": "Montenegro", "country": "Montenegro"},
        {"location": "Morocco", "country": "Morocco"},
        {"location": "Mozambique", "country": "Mozambique"},
        {"location": "Myanmar", "country": "Myanmar"},
        {"location": "Namibia", "country": "Namibia"},
        {"location": "Nauru", "country": "Nauru"},
        {"location": "Nepal", "country": "Nepal"},
        {"location": "Netherlands", "country": "Netherlands"},
        {"location": "New Zealand", "country": "New Zealand"},
        {"location": "Nicaragua", "country": "Nicaragua"},
        {"location": "Niger", "country": "Niger"},
        {"location": "Nigeria", "country": "Nigeria"},
        {"location": "North Macedonia", "country": "North Macedonia"},
        {"location": "Norway", "country": "Norway"},
        {"location": "Oman", "country": "Oman"},
        {"location": "Pakistan", "country": "Pakistan"},
        {"location": "Palau", "country": "Palau"},
        {"location": "Panama", "country": "Panama"},
        {"location": "Papua New Guinea", "country": "Papua New Guinea"},
        {"location": "Paraguay", "country": "Paraguay"},
        {"location": "Peru", "country": "Peru"},
        {"location": "Philippines", "country": "Philippines"},
        {"location": "Poland", "country": "Poland"},
        {"location": "Portugal", "country": "Portugal"},
        {"location": "Qatar", "country": "Qatar"},
        {"location": "Romania", "country": "Romania"},
        {"location": "Russia", "country": "Russia"},
        {"location": "Rwanda", "country": "Rwanda"},
        {"location": "Saint Kitts and Nevis", "country": "Saint Kitts and Nevis"},
        {"location": "Saint Lucia", "country": "Saint Lucia"},
        {"location": "Saint Vincent and the Grenadines", "country": "Saint Vincent and the Grenadines"},
        {"location": "Samoa", "country": "Samoa"},
        {"location": "San Marino", "country": "San Marino"},
        {"location": "Sao Tome and Principe", "country": "Sao Tome and Principe"},
        {"location": "Saudi Arabia", "country": "Saudi Arabia"},
        {"location": "Senegal", "country": "Senegal"},
        {"location": "Serbia", "country": "Serbia"},
        {"location": "Seychelles", "country": "Seychelles"},
        {"location": "Sierra Leone", "country": "Sierra Leone"},
        {"location": "Singapore", "country": "Singapore"},
        {"location": "Slovakia", "country": "Slovakia"},
        {"location": "Slovenia", "country": "Slovenia"},
        {"location": "Solomon Islands", "country": "Solomon Islands"},
        {"location": "Somalia", "country": "Somalia"},
        {"location": "South Africa", "country": "South Africa"},
        {"location": "South Korea", "country": "South Korea"},
        {"location": "South Sudan", "country": "South Sudan"},
        {"location": "Spain", "country": "Spain"},
        {"location": "Sri Lanka", "country": "Sri Lanka"},
        {"location": "Sudan", "country": "Sudan"},
        {"location": "Suriname", "country": "Suriname"},
        {"location": "Sweden", "country": "Sweden"},
        {"location": "Switzerland", "country": "Switzerland"},
        {"location": "Syria", "country": "Syria"},
        {"location": "Taiwan", "country": "Taiwan"},
        {"location": "Tajikistan", "country": "Tajikistan"},
        {"location": "Tanzania", "country": "Tanzania"},
        {"location": "Thailand", "country": "Thailand"},
        {"location": "Timor-Leste", "country": "Timor-Leste"},
        {"location": "Togo", "country": "Togo"},
        {"location": "Tonga", "country": "Tonga"},
        {"location": "Trinidad and Tobago", "country": "Trinidad and Tobago"},
        {"location": "Tunisia", "country": "Tunisia"},
        {"location": "Turkey", "country": "Turkey"},
        {"location": "Turkmenistan", "country": "Turkmenistan"},
        {"location": "Tuvalu", "country": "Tuvalu"},
        {"location": "Uganda", "country": "Uganda"},
        {"location": "Ukraine", "country": "Ukraine"},
        {"location": "United Arab Emirates", "country": "United Arab Emirates"},
        {"location": "United Kingdom", "country": "United Kingdom"},
        {"location": "United States", "country": "United States"},
        {"location": "Uruguay", "country": "Uruguay"},
        {"location": "Uzbekistan", "country": "Uzbekistan"},
        {"location": "Vanuatu", "country": "Vanuatu"},
        {"location": "Vatican City", "country": "Vatican City"},
        {"location": "Venezuela", "country": "Venezuela"},
        {"location": "Vietnam", "country": "Vietnam"},
        {"location": "Yemen", "country": "Yemen"},
        {"location": "Zambia", "country": "Zambia"},
        {"location": "Zimbabwe", "country": "Zimbabwe"},
        {"location": "eferferf", "country": "eferferf"}
      ].where((suggestion) {
        return suggestion['location']!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }
}
