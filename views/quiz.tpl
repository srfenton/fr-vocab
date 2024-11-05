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
        .answer-choices:hover {
            background-color: #e0e0e0; /* Darker background on hover */
        }
        .question {
            font-size: 3em;
            text-align: center;
        }


       .alert {
            padding: 20px;
            color: white;
            opacity: 1;
            transition: opacity 0.6s;
            margin-bottom: 15px;
            display: none; /* Initially hidden */
        }

        .alert.correct {background-color: #04AA6D;}
        .alert.incorrect {background-color: #ff9800;}

        .closebtn {
        margin-left: 15px;
        color: white;
        font-weight: bold;
        float: right;
        font-size: 22px;
        line-height: 20px;
        cursor: pointer;
        transition: 0.3s;
        }

        .closebtn:hover {
        color: black;
        }
    </style>
</head>
<body>

<!-- Feedback Divs -->
    <div id="correctAlert" class="alert correct">
      <span class="closebtn" onclick="closeAlert('correctAlert')">&times;</span>  
      <strong>Correct!</strong>     
    </div>

    <div id="incorrectAlert" class="alert incorrect">
      <span class="closebtn" onclick="closeAlert('incorrectAlert')">&times;</span>  
      <strong>This answer is not correct</strong> The correct answer is: <span id="correctAnswer"></span>.
    </div>

    <p class="question">{{current_question[0]}}</p>

    <table>
        % for x in current_question[2]:
            <tr>
                <td>
                    <!--<button class="answer-choices" onclick="handleButtonClick('{{current_question[1]}}','{{x}}')">{{x}}</button>-->
                    <button class="answer-choices" data-correct-answer="{{current_question[1]}}" data-selected-answer="{{x}}" onclick="handleButtonClick(this)">{{x}}</button>

                </td>
            </tr>
        % end
    </table>
    <p>{{question_index+1}} / {{question_count}}</p>
    <p><a href="/">Go back to Home Page</a></p>

    <form action="/next" method="post">
        <input id="missedWordInput" name="missed_word" type="hidden" value=""/>
        <button class='.answer-choices' type="submit" id="button-0">Next</button>
    </form>



    <script>
        function evaluateAnswer(correct_answer,selectedAnswer) {
            if(correct_answer===selectedAnswer){
                showAlert('correctAlert');  // Show correct answer alert
                    }
                else{
                    document.getElementById('correctAnswer').innerText = correct_answer;
                    setMissedWord(correct_answer);
                    showAlert('incorrectAlert');  // Show incorrect answer alert

                }
        }

        function setMissedWord(correct_answer) {
            document.getElementById("missedWordInput").value = correct_answer;
        }
        
        //function handleButtonClick(correct_answer, selectedAnswer) {
        function handleButtonClick(buttonElement) {
            const correct_answer = decodeURIComponent(buttonElement.getAttribute('data-correct-answer'));
            const selectedAnswer = decodeURIComponent(buttonElement.getAttribute('data-selected-answer'));
            evaluateAnswer(correct_answer, selectedAnswer);
    
            setTimeout(function() {
                document.getElementById('button-0').click(); 
            }, 750);
        }

        function showAlert(alertId) {
        var alertElement = document.getElementById(alertId);
        alertElement.style.display = "block";  // Show the alert
        alertElement.style.opacity = "1";      // Ensure full opacity
    }

        function closeAlert(alertId) {
            var alertElement = document.getElementById(alertId);
            alertElement.style.opacity = "0";      // Fade out the alert
            setTimeout(function() { 
                alertElement.style.display = "none"; 
            }, 600);  // Wait for fade-out to complete
        }

    
        


    </script>
</body>
</html>
