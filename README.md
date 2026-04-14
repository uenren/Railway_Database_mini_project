# Railway_Database_mini_project
A full-stack Railway Database Management System built with Python, Flask, and SQLite. Features schedule tracking, ticket booking, graph-based pathfinding, and an integrated SQL console.
🚆 Indian Railways Database Management System (DBMS)
A full-stack web application designed to simulate the core operations of the Indian Railways network. This project features a robust relational database that handles railway zones, stations, train fleets, track networks, timetables, and ticket bookings. It is powered by a Python/Flask REST API backend and a highly dynamic, responsive Vanilla JavaScript frontend.

✨ Key Features
Interactive Dashboard: Real-time KPIs tracking total zones, stations, active trains, and passenger bookings.

Train & Station Management: Filter, view, and add data for 18 railway zones, 100+ stations, and a fleet of 150+ trains (including Rajdhani, Shatabdi, and Vande Bharat expresses).

Dynamic Route Search: Query available trains between source and destination stations based on sequential schedule data.

Graph-Based Pathfinding: Implements Dijkstra's Algorithm on the backend to calculate the shortest path and distance across the track network.

Ticket Booking System: Simulate passenger reservations with automated PNR generation, seat allocation, and journey tracking.

Integrated SQL Console: A built-in terminal UI that allows users to execute raw SQLite queries directly from the browser for testing and educational purposes.

🛠️ Tech Stack
Frontend: HTML5, CSS3 (Custom Variables & Grid/Flexbox layouts), Vanilla JavaScript (Async/Await & Fetch API)

Backend: Python 3, Flask

Database: SQLite3

🗄️ Database Schema Overview
The relational database is structured in 3rd Normal Form (3NF) to ensure data integrity:

zones - Stores the 18 Indian Railway zones and headquarters.

stations - Stores station codes, names, and categories (linked to zones).

trains - Stores train numbers, types, and coach capacities.

tracks - Stores bidirectional graph edges (distances) between stations.

schedule - Stores the sequenced arrival/departure timetables for trains.

bookings - Stores passenger reservations, PNRs, and seat numbers.

🚀 How to Run Locally
1. Clone the repository

Bash
git clone https://github.com/yourusername/railway-dbms.git
cd railway-dbms

2. Install dependencies
Make sure you have Python 3 installed. Then, install Flask:

Bash
pip install Flask
3. Run the application

Bash
python app.py
Note: The application will automatically detect if the database is empty and inject the seed.sql data to build the initial tables.

4. Open in Browser
Navigate to http://127.0.0.1:5000 to access the dashboard.
