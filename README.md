A library of reusable abstract data types templates for constructing verifiable specifications.


The project maintains a library of verifiable specifications templates for idiomatic software behaviors. 


Instead of writing verifiable specifications for you components from scratch, you can apply the ready-to-use templates.
The resulting specifications are verifiable either through parameterized unit testing or automated program proving.
The templates include natural-language explanations in the form of code comments, and links to relevant online resources.


To get started with the project, clone the project inside your $ISE_LIBRARY/library directory:

1. cd $ISE_LIBRARY/library
2. git clone https://github.com/anaumchev/requirements_templates.git

Having done that, connect it to your Eiffel project as an external library.

If you want to apply a template, say, STACK_ADT.e:

1. Inherit from STACK_ADT in a new class marked as "expanded" (https://www.eiffel.org/doc/eiffel/ET-_The_Dynamic_Structure-_Execution_Model#Type_categories), providing the types you want to verify as generic arguments.
2. Implement all the STACK_ADT features marked as "deferred" (https://www.eiffel.org/doc/eiffel/ET-_Inheritance#Deferred_features_and_classes).
3. The routines marked as "frozen" (https://www.eiffel.org/doc/eiffel/Eiffel_programming_language_reserved_words#frozen) are the abstract data type (ADT) axioms describing the behavior. You will need to verify them.
4. If you use testing, call each of the "frozen" routines with arguments that meet the routine's precondition.
5. A precondition failure denotes an error in the test, while a postcondition failure denotes an error in the implementation of your type.

The following project contains examples of applying the templates: https://github.com/anaumchev/testing_reusable_requirements.


To get help with the project, contact Alexandr Naumchev by: anaumchev@gmail.com.
