<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Select a Lesson</title>
    <link rel="stylesheet" href="/styles.css">
        <style>
        
        h1, p {
            text-align: center;
        }
        ul {
            list-style-type: none; /* Remove bullet points */
            padding: 0;
            text-align: center;
        }
        li {
            margin: 2px 0; /* Reduce space between items */
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
        .answer-choices:hover {
            background-color: #e0e0e0; /* Darker background on hover */
        }
        .question {
            font-size: 3em;
            text-align: center;
        }
    </style>
</head>
<body>
    <p class ="question">{{current_question}}</p>
    <ul>
        for x in current_question[3]:
            <li>
                <form action="/submit?answer=<%= jsonData[key] %>" method="POST">
                    <button type="submit" class="answer-choices"><%= jsonData[key] %></button>
                </form>
            </li>
    </ul>
    <p><%= question_number %> / <%= question_count %></p>
    <p><a href="/">Go back to Home Page</a></p>
</body>
</html>