//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;
 contract QuestionAnswerContract {
    // Mapping of students to their questions
    mapping(address => mapping(string => Question)) public studentQuestions;

    // Mapping of teachers to their answers
    mapping(address => mapping(string => Answer)) public teacherAnswers;

    // Event emitted when a student asks a question
    event QuestionAsked(address student, string topic, string question);

    // Event emitted when a teacher answers a question
    event QuestionAnswered(address teacher, string topic, string answer);

    // Struct to represent a question
    struct Question {
        string topic;
        string question;
        uint fee;
    }

    // Struct to represent an answer
    struct Answer {
        string answer;
        uint feePaid;
    }

    // Function to ask a question
    function askQuestion(string memory _topic, string memory _question, uint _fee) public {
        // Create a new question struct
        Question memory newQuestion = Question(_topic, _question, _fee);

        // Add the question to the student's questions mapping
        studentQuestions[msg.sender][_topic] = newQuestion;

        // Emit the QuestionAsked event
        emit QuestionAsked(msg.sender, _topic, _question);
    }

    // Function to answer a question
    function answerQuestion(string memory _topic, string memory _answer) public {
        // Get the question from the student's questions mapping
        Question memory question = studentQuestions[msg.sender][_topic];

        // Create a new answer struct
        Answer memory newAnswer = Answer(_answer, question.fee);

        // Add the answer to the teacher's answers mapping
        teacherAnswers[msg.sender][_topic] = newAnswer;

        // Pay the fee to the teacher
        payable(msg.sender).transfer(question.fee);

        // Emit the QuestionAnswered event
        emit QuestionAnswered(msg.sender, _topic, _answer);
    }
}