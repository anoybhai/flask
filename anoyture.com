<!DOCTYPE html>
<html lang="bn">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Free Fire Tournament</title>
  <style>
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background-color: #1b1b1b;
      color: #f0f0f0;
      margin: 0; padding: 0;
    }
    header {
      background: #ff3c00;
      padding: 20px;
      text-align: center;
      font-size: 2em;
      font-weight: bold;
      letter-spacing: 2px;
    }
    main {
      max-width: 900px;
      margin: 30px auto;
      padding: 20px;
      background: #222;
      border-radius: 8px;
    }
    h2 {
      border-bottom: 2px solid #ff3c00;
      padding-bottom: 5px;
    }
    form {
      display: flex;
      flex-direction: column;
      max-width: 400px;
      margin-bottom: 30px;
    }
    label {
      margin: 10px 0 5px;
    }
    input, select {
      padding: 8px;
      border-radius: 5px;
      border: none;
      font-size: 1em;
    }
    button {
      margin-top: 15px;
      padding: 10px;
      background-color: #ff3c00;
      border: none;
      color: white;
      font-weight: bold;
      cursor: pointer;
      border-radius: 5px;
      font-size: 1.1em;
    }
    button:hover {
      background-color: #e03e00;
    }
    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 10px;
    }
    th, td {
      border: 1px solid #555;
      padding: 10px;
      text-align: center;
    }
    th {
      background-color: #ff3c00;
      color: white;
    }
    footer {
      text-align: center;
      padding: 20px;
      background-color: #111;
      margin-top: 40px;
      color: #aaa;
      font-size: 0.9em;
    }
    @media (max-width: 600px) {
      main {
        margin: 10px;
        padding: 15px;
      }
      form {
        max-width: 100%;
      }
      table, th, td {
        font-size: 0.9em;
      }
    }
    #searchBar {
      padding: 8px;
      width: 100%;
      max-width: 300px;
      margin-bottom: 10px;
      border-radius: 5px;
      border: none;
      font-size: 1em;
    }
  </style>
</head>
<body>

  <header>Free Fire Tournament 2025</header>

  <main>
    <section id="info">
      <h2>Tournament Information</h2>
      <p>Join the biggest Free Fire tournament of 2025! Compete with the best players and win exciting prizes.</p>
      <ul>
        <li><strong>Date:</strong> 15 August 2025</li>
        <li><strong>Entry Fee:</strong> 50 Taka</li>
        <li><strong>Prize:</strong> 1st: 5000 Taka, 2nd: 3000 Taka, 3rd: 1000 Taka</li>
      </ul>
    </section>

    <section id="register">
      <h2>Register Now</h2>
      <form id="regForm">
        <label for="playerName">Player Name</label>
        <input type="text" id="playerName" name="playerName" required placeholder="Your in-game name" />
        
        <label for="teamName">Team Name</label>
        <input type="text" id="teamName" name="teamName" placeholder="If any" />

        <label for="phone">Phone Number</label>
        <input type="tel" id="phone" name="phone" required placeholder="01XXXXXXXXX" pattern="[0-9]{11}" />
        
        <label for="paymentMethod">Payment Method</label>
        <select id="paymentMethod" name="paymentMethod" required>
          <option value="">Select Payment Method</option>
          <option value="Bkash">Bkash</option>
          <option value="Rocket">Rocket</option>
          <option value="Nagad">Nagad</option>
        </select>
        
        <button type="submit">Submit Registration</button>
      </form>
    </section>

    <section id="leaderboard">
      <h2>Leaderboard</h2>
      <input type="text" id="searchBar" placeholder="Search player name..." />
      <table>
        <thead>
          <tr>
            <th>Rank</th>
            <th>Player Name</th>
            <th>Team Name</th>
            <th>Points</th>
          </tr>
        </thead>
        <tbody id="leaderboardBody">
          <tr><td>1</td><td>ShadowKing</td><td>Ghost Squad</td><td>120</td></tr>
          <tr><td>2</td><td>FireArrow</td><td>Blaze</td><td>115</td></tr>
          <tr><td>3</td><td>DragonSlayer</td><td>Dragon Riders</td><td>110</td></tr>
        </tbody>
      </table>
    </section>
  </main>

  <footer>
    Contact us: info@freefiretournament.com | Phone: 017XXXXXXXX
  </footer>

  <script>
    const form = document.getElementById('regForm');
    const leaderboardBody = document.getElementById('leaderboardBody');
    const searchBar = document.getElementById('searchBar');
    let players = [
      {playerName: 'ShadowKing', teamName: 'Ghost Squad', points: 120},
      {playerName: 'FireArrow', teamName: 'Blaze', points: 115},
      {playerName: 'DragonSlayer', teamName: 'Dragon Riders', points: 110},
    ];

    function renderLeaderboard(data) {
      leaderboardBody.innerHTML = '';
      data.forEach((player, index) => {
        const tr = document.createElement('tr');
        tr.innerHTML = `
          <td>${index + 1}</td>
          <td>${player.playerName}</td>
          <td>${player.teamName}</td>
          <td>${player.points}</td>
        `;
        leaderboardBody.appendChild(tr);
      });
    }

    // Initially render leaderboard
    renderLeaderboard(players);

    form.addEventListener('submit', function(e) {
      e.preventDefault();
      
      const playerName = form.playerName.value.trim();
      const teamName = form.teamName.value.trim() || 'Solo';
      const phone = form.phone.value.trim();
      const payment = form.paymentMethod.value;
      
      if (!playerName || !phone || !payment) {
        alert('Please fill all required fields.');
        return;
      }
      if (!/^[0-9]{11}$/.test(phone)) {
        alert('Phone number must be 11 digits.');
        return;
      }

      // Add new player with 0 points initially
      players.push({playerName, teamName, points: 0});

      // Sort players by points descending
      players.sort((a,b) => b.points - a.points);

      renderLeaderboard(players);
      alert(`Thank you, ${playerName}, for registering!\nTeam: ${teamName}\nPayment Method: ${payment}`);
      form.reset();
    });

    // Search filter
    searchBar.addEventListener('input', function() {
      const term = this.value.toLowerCase();
      const filtered = players.filter(p => p.playerName.toLowerCase().includes(term));
      renderLeaderboard(filtered);
    });
  </script>

</body>
</html>
