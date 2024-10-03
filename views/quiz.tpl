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
        table {
            list-style-type: none; /* Remove bullet points */
            padding: 0;
            text-align: center;
        }
        tr {
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
    <p class="question">{{current_question[0]}}</p>
    <table>
        % for x in current_question[2]:
            <tr>
                <td>
                    <button class="answer-choices" onclick="evaluateAnswer('{{current_question[2]}}','{{x}}')">{{x}}</button>
                </td>
            </tr>
        % end
    </table>

    <p>{{question_index+1}} / {{question_count}}</p>
    <p><a href="/">Go back to Home Page</a></p>

    <script>
        function evaluateAnswer(correct_answer,selectedAnswer) {
            // Store the selected answer in a variable or take any action you'd like
            console.log("Selected answer:", selectedAnswer);
            
            // Display the selected answer in an alert, or handle it in any way you prefer
            if(correct_answer===selectedAnswer){alert("You selected: " + selectedAnswer + " which is correct);}
            else{}
        
            
            // Example: You can send this answer to the backend using AJAX or continue to the next question
            // Here, you could write an AJAX request to submit the answer without refreshing the page
            // Example:
            // fetch('/submit_answer', {
            //    method: 'POST',
            //    headers: { 'Content-Type': 'application/json' },
            //    body: JSON.stringify({ answer: selectedAnswer })
            // })
            // .then(response => response.json())
            // .then(data => {
            //    console.log('Success:', data);
            //    // Move to the next question or give feedback
            // })
            // .catch((error) => {
            //    console.error('Error:', error);
            // });
        }
    </script>
</body>
</html>
