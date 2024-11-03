
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>lessons</title>
    <style>
          h1, p {
              text-align: center;
          }
          table {
              width: 100%; /* Make the table full width */
              margin: 0 auto; /* Center the table */
              text-align: center; /* Center the table content */
              border-collapse: collapse; /* Collapse borders for a cleaner look */
          }
          tr {
              margin: 2px 0; /* Reduce space between items */
              text-align: center;
          }
          td {
              padding: 10px; /* Add padding to table cells */
              text-align: center;
          }
          .answer-choices {
              text-decoration: none; /* Remove underline */
              color: #000; /* Black text */
              text-align: center;
              font-size: 1.5em; /* Increase font size */
              padding: 10px 20px; /* Add padding for better click area */
              border: none; /* Remove default button border */
              border-radius: 5px; /* Add rounded corners */
              background-color: #f0f0f0; /* Light background color */
              cursor: pointer; /* Change cursor to pointer on hover */
              transition: background-color 0.3s; /* Smooth transition for hover effect */
          }
        </style>
      
</head>
<body>
  <table>
    % for x in lessons:
      <tr>
        <td>
          <form action="/select" method="post">
          <input name="selected_lesson" type="hidden" value="{{x}}"/>
          <button type="submit">{{x}}</button>
        </form>
        </td>
      </tr>

    % end
  </table>
</body>
</html>