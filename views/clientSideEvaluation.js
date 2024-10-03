function evaluateAnswer(correct_answer,selectedAnswer) {
    // Store the selected answer in a variable or take any action you'd like
    console.log("Selected answer:", selectedAnswer);
    
    // Display the selected answer in an alert, or handle it in any way you prefer
    if(correct_answer===selectedAnswer){
        // alert("You selected: " + selectedAnswer + " which is correct");
        console.log("You selected: " + selectedAnswer + " which is correct");
            }
        else{
            // alert("You selected: " + selectedAnswer + " which is incorrect. The correct answer is " + correct_answer);
            console.log(("You selected: " + selectedAnswer + " which is incorrect. The correct answer is " + correct_answer));
        }
    }

    evaluateAnswer('test', 'dog')

function setMissedWord(selectedAnswer){
    pass
}