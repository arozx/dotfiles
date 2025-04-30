import re

# Input multiline string
input_text = """Analysis\t4
Introduction\t4
INTRO\t4
WHAT\t4
WHY\t4
HOW\t4
Key Terminology\t5
Document Structure\t5
Interview\t6
Observing existing systems\t7
Lichess (lichess.org)\t7
Chess.com (chess.com)\t9
ChessBase (chessbase.com)\t11
Conclusion resulting from the evaluation of existing systems\t12
Tasks to be Computerised and the Benefits of Computerising\t13
Tasks:\t13
Qualitative Benefits:\t13
Quantitative Benefits:\t13
Objectives for the Proposed System\t14
Flowcharts\t16
Move Validation Flowchart\t16
Usability for a Chess Application\t17
Possible SQL Queries\t18
Design\t20
IOPS Chart of gameplay\t20
Hierarchy Chart\t21
System Flowchart\t22
Data Flow Diagram (DFD)\t23
Database Schema\t24
Entity Relationship Diagram (ERD)\t25
Justification of Design Choices\t26
Object-Oriented Programming Class Design\t27
Class: ChessBoard(QWidget)\t28
Class: PromotionWindow(QWidget)\t30
Class: Piece\t31
Class: Rook (Child of Piece)\t31
Class: Bishop (Child of Piece)\t32
Class: Knight (Child of Piece)\t33
Class: Queen (Child of Piece)\t33
Class: Pawn (Child of Piece)\t34
Class: ChessPiece(QLabel)\t34
Class: ChessBoardUI(QWidget)\t35
Class: NetworkedChessBoardUI(ChessBoardUI)\t37
Algorithms\t38
Monte-Carlo (chess engine)\t38
Password-Based Key Derivation Function 2 (pbkdf2)\t39
Argon 2\t40
Negamax evaluation framework\t41
Alpha-beta pruning\t42
UI Design Concepts\t43
Final UI Design\t46
System Architecture\t48
Technical Solution\t49
Object-Oriented Programming (OOP)\t49
Graphical UI (GUI) Development\t51
Algorithm Implementation\t52
Board Evaluation Function\t54
Database Interaction and Security\t56
Unit Testing and Test-Driven Development\t57
Concurrency and Performance Optimization\t59
Integration with External Data Sources\t60
Version Control and Continuous Integration (VSC & CI)\t61
Code Style and Linting\t62
Error Handling and Logging\t63
Use of Advanced Python Features\t64
Networking\t65
Client - Original implementation\t65
Client - Final implementation\t66
Server - Original implementation\t68
Server - Final implementation\t69
Handling of Unexpected Technical Challenges\t71
Deployment of Chess Application\t73
Architecture & deployment plan V1\t73
Architecture & deployment plan V2\t74
Justification for change in architecture and deployment plan\t76
Benefits of the Azure-Based Deployment\t76
Future Enhancements.\t76
Testing\t77
Overview\t77
Test Plan\t77
Database Connector Tests\t77
Evaluation Board Tests\t84
Monte Carlo Tree Search (MCTS) Tests\t90
GUI Tests\t96
Chess Board Tests\t100
Networking Tests\t105
Execution Plan:\t109
User Feedback & Iterative Improvements:\t110
Evaluation\t111
Comparison Against Objectives\t111
Potential for Future Developments\t113
Registration and Login\t115
Rules & Game\t116
Data & Statistics\t118
Customisation\t118
AI Player\t118
Key Resources\t119
Build Log\t120
Features\t120
Bug Fixes\t122
More Features\t122References\t124"""

# Process and format output
lines = input_text.splitlines()
output = []

for line in lines:
    # Remove trailing tab + number
    cleaned = re.sub(r'\t\d+$', '', line).strip()
    output.append(f"- [ ] {cleaned}")

# Print final result
formatted_output = '\n'.join(output)
print(formatted_output)
