
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>lessons</title>
    <style>
    /* General page setup */
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f9;
        margin: 0;
        padding: 0;
    }

    /* Heading */
    h1 {
        text-align: center;
        font-size: 2rem;
        color: #333;
        margin: 20px 0;
    }

    /* Table layout */
    table {
        width: 90%; /* Narrower table width for a centered appearance */
        margin: 0 auto;
        border-collapse: separate;
        border-spacing: 10px; /* Adds spacing between rows */
    }

    /* Table rows and cells */
    tr {
        text-align: center;
    }

    td {
        padding: 0;
    }

    /* Button styling */
    button {
        width: 100%; /* Full width button for mobile-friendliness */
        padding: 15px 10px;
        font-size: 1.1rem;
        color: #fff;
        background-color: #5a67d8; /* Stylish blue shade */
        border: none;
        border-radius: 8px;
        cursor: pointer;
        transition: background-color 0.3s ease, transform 0.2s ease;
        box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    }

    /* Hover effect for buttons */
    button:hover {
        background-color: #4c51bf; /* Slightly darker blue for hover */
        transform: translateY(-2px); /* Subtle lift effect */
    }

    /* Active button effect */
    button:active {
        background-color: #434190;
        transform: translateY(0); /* Reset lift on click */
    }

    /* Responsive adjustments */
    @media (max-width: 768px) {
        button {
            font-size: 1rem;
            padding: 12px 8px;
        }
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