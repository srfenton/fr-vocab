<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    body {
      font-family: Arial, sans-serif;
      color: #333;
      padding: 0 10px;
      background-color: #f5f5f5;
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
      margin: 0;
    }
    
    .container {
      max-width: 500px;
      width: 100%;
      background-color: white;
      border-radius: 8px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      padding: 20px;
      text-align: center;
    }
    
    h2 {
      color: #4CAF50;
      margin: 0 0 10px;
    }
    
    .score {
      font-size: 1.5em;
      margin: 10px 0;
      color: #555;
    }
    
    table {
      width: 100%;
      margin: 20px 0;
      border-collapse: collapse;
    }
    
    table, th, td {
      border: 1px solid #ddd;
    }
    
    td {
      padding: 8px;
      font-size: 1em;
      color: #666;
    }
    
    button {
      background-color: #4CAF50;
      color: white;
      padding: 10px 20px;
      font-size: 1em;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      margin-top: 15px;
      width: 100%;
    }
    
    button:hover {
      background-color: #45a049;
    }
    
    .footer-text {
      margin-top: 15px;
      color: #777;
      font-size: 0.9em;
    }
  </style>
</head>
<body>

<div class="container">
  <h2>Quiz Summary</h2>
  <p class="score">Score: {{score}} / {{question_count}}</p>

  <table>
    <thead>
      <tr>
        <th>Missed Words</th>
      </tr>
    </thead>
    <tbody>
      % for x in missed_words:
        <tr>
          <td>{{x}}</td>
        </tr>
      % end
    </tbody>
  </table>

  <form action="/reset" method="post">
    <input name="selected_lesson" type="hidden"/>
    <button type="submit">Reset & Go Home</button>
  </form>

  <p class="footer-text">All done!</p>
</div>

</body>
</html>
