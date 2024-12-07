<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Lessons</title>
  <style>
    /* General page setup */
    body {
        font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
        background-color: #f9f9fb; /* Light background */
        color: #1d1d1f; /* Neutral text color */
        margin: 0;
        padding: 0;
        display: flex;
        min-height: 100vh;
    }


    /* Main content container */
    .container {
        padding: 20px;
        flex-grow: 1;
        display: flex;
        flex-direction: column;
        align-items: center;
        background-color: #ffffff; /* White main area */
    }

    /* Table layout */
    table {
        width: 100%;
        max-width: 600px;
        border-collapse: separate;
        border-spacing: 12px;
    }

    /* Button styling */
    .button {
        padding: 12px 24px;
        font-size: 1rem;
        color: #333;
        background-color: #ffffff;
        border: 1px solid #e3e4e8; /* Subtle border for buttons */
        border-radius: 8px; /* Rounded corners */
        cursor: pointer;
        transition: background-color 0.3s ease, transform 0.2s ease;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.08); /* Subtle shadow */
        text-align: center;
    }

    /* Button hover effect */
    .button:hover {
        background-color: #f1f1f4;
        border-color: #d1d1d4; /* Slightly darker border on hover */
        transform: translateY(-2px);
    }

    /* Button active effect */
    .button:active {
        background-color: #e9e9eb;
        transform: translateY(0);
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
    }

    /* Responsive adjustments */
    @media (max-width: 768px) {
        .sidebar {
            min-width: 60px; /* Narrower sidebar on smaller screens */
        }

        .sidebar .vertical-text {
            font-size: 2rem; /* Slightly smaller font for mobile */
            letter-spacing: 0.1rem;
        }

        .container {
            padding: 10px;
        }

        .button {
            font-size: 0.9rem; /* Smaller button text on mobile */
            padding: 10px 20px;
        }
    }
  </style>
</head>
<body>
  <div class="container">
    <table>
      % for x in lessons:
        <tr>
          <td>
            <form action="/select" method="post">
              <input name="selected_lesson" type="hidden" value="{{x}}"/>
              <button type="submit" class="button">{{x.replace('.json','').replace('_',' ')}}</button>
            </form>
          </td>
        </tr>
      % end
        <tr>
    <td>
          <form action="/select" method="post">
            <input name="selected_lesson" type="hidden" value="combined"/>
            <button type="submit" class="button">Combined</button>
          </form>
        </td>
      </tr>
    </table>
  </div>
</body>
</html>
