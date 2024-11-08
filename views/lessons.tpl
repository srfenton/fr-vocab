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
        background-color: #f9f9fb;
        color: #1d1d1f;
        margin: 0;
        padding: 0;
        display: flex;
        min-height: 100vh;
    }

    /* Sidebar for vertical "Lessons" text */
    .sidebar {
        display: flex;
        justify-content: center;
        align-items: center;
        background-color: #f9f9fb; /* Same color as main area for seamless transition */
        padding: 10px;
        min-width: 100px;
    }

    .sidebar .vertical-text {
        display: flex;
        flex-direction: column;
        align-items: center;
        font-size: 3.5rem; /* Default large font size */
        letter-spacing: 0.15rem;
        color: #1d1d1f;
        text-align: center;
        margin: 0;
    }

    /* Main content container */
    .container {
        padding: 20px;
        flex-grow: 1;
        display: flex;
        flex-direction: column;
        align-items: center;
        background-color: #f9f9fb; /* Same color as sidebar for seamless integration */
    }

    /* Table layout */
    table {
        width: 100%;
        max-width: 600px;
        border-collapse: separate;
        border-spacing: 12px;
    }

    /* Borderless button styling */
    .button {
        padding: 12px 24px;
        font-size: 1rem;
        color: #333;
        background-color: #fff;
        border: none; /* No border */
        border-radius: 8px;
        cursor: pointer;
        transition: background-color 0.3s ease, transform 0.2s ease;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.08);
        width: 80%;
        text-align: center;
    }

    /* Hover effect for buttons */
    .button:hover {
        background-color: #f1f1f4;
        transform: translateY(-2px);
    }

    /* Active button effect */
    .button:active {
        background-color: #e5e5ea;
        transform: translateY(0);
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
    }

    /* Mobile responsiveness adjustments */
    @media (max-width: 768px) {
        .sidebar {
            min-width: 50px; /* Reduce the sidebar width on mobile */
        }

        .sidebar .vertical-text {
            font-size: 2.5rem; /* Smaller font size for mobile */
            letter-spacing: 0.1rem; /* Slightly reduced spacing */
        }

        .container {
            padding: 10px;
        }

        .button {
            font-size: 0.9rem; /* Slightly smaller button text */
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
