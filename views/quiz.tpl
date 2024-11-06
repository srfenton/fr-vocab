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
            width: 100%;
            margin: 0 auto;
            text-align: center;
            border-collapse: collapse;
        }
        tr, td {
            text-align: center;
            padding: 10px;
        }
        .answer-choices {
            text-decoration: none;
            color: #000;
            font-size: 1.5em;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            background-color: #f0f0f0;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .answer-choices:hover {
            background-color: #e0e0e0;
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
            display: none;
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
        .closebtn:hover { color: black; }

        /* Center the form buttons as footer links */
        .footer-links-container {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 20px;
        }

        .footer-button {
            background: transparent;
            border: none;
            color: #0073e6;
            font-size: 1.2em;
            cursor: pointer;
            text-decoration: none;
            padding: 10px;
            transition: color 0.3s;
        }

        .footer-button:hover {
            color: #005bb5;
            text-decoration: underline;
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
                    <button class="answer-choices" data-correct-answer="{{current_question[1]}}" data-selected-answer="{{x}}" onclick="handleButtonClick(this)">{{x}}</button>
                </td>
            </tr>
        % end
    </table>
    <p>{{question_index+1}} / {{question_count}}</p>

    <div class="footer-links-container">
        <form action="/lessons" method="get" style="display: inline;">
            <input name="selected_lesson" type="hidden"/>
            <button type="submit" class="footer-button">Lessons</button>
        </form>
        <form action="/reset" method="post" style="display: inline;">
            <input name="selected_lesson" type="hidden"/>
            <button type="submit" class="footer-button">Reset & Go Home</button>
        </form>
        <form action="/next" method="post" style="display: inline;">
            <input id="missedWordInput" name="missed_word" type="hidden" value=""/>
            <button type="submit" class="footer-button" id="button-0">Next</button>
        </form>
    </div>

    <script>
        function evaluateAnswer(correct_answer, selectedAnswer) {
            if (correct_answer === selectedAnswer) {
                showAlert('correctAlert');
            } else {
                document.getElementById('correctAnswer').innerText = correct_answer;
                setMissedWord(correct_answer);
                showAlert('incorrectAlert');
            }
        }

        function setMissedWord(correct_answer) {
            document.getElementById("missedWordInput").value = correct_answer;
        }
        
        function handleButtonClick(buttonElement) {
            const correct_answer = decodeURIComponent(buttonElement.getAttribute('data-correct-answer'));
            const selectedAnswer = decodeURIComponent(buttonElement.getAttribute('data-selected-answer'));
            evaluateAnswer(correct_answer, selectedAnswer);

            setTimeout(function() {
                document.getElementById('button-0').click(); 
            }, 1000);
        }

        function showAlert(alertId) {
            var alertElement = document.getElementById(alertId);
            alertElement.style.display = "block";
            alertElement.style.opacity = "1";
        }

        function closeAlert(alertId) {
            var alertElement = document.getElementById(alertId);
            alertElement.style.opacity = "0";
            setTimeout(function() { 
                alertElement.style.display = "none"; 
            }, 600);
        }
    </script>
</body>
</html>
