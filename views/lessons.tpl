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

    /* Sidebar styling */
    .sidebar {
        display: flex;
        justify-content: center;
        align-items: center;
        background-color: #f9f9fb;
        padding: 10px;
        min-width: 100px;
        border-right: 1px solid #e3e4e8; /* Subtle border for separation */
    }

    .sidebar .vertical-text {
        display: flex;
        flex-direction: column;
        align-items: center;
        font-size: 2.5rem; /* Large font size */
        letter-spacing: 0.15rem;
        color: #2d2d2d;
        margin: 0;
        font-weight: bold;
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
  <div class="sidebar">
    <div class="vertical-text">
      <span>L</span>
      <span>E</span>
      <span>S</span>
      <span>S</span>
      <span>O</span>
      <span>N</span>
      <span>S</span>
    </div>
  </div>
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
    </table>
  </div>
</body>
</html>
