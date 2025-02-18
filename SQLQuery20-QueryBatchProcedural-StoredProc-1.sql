USE sampleABG
GO

ALTER PROCEDURE increase_budget(
@percent INT= 5
)
AS
	BEGIN
	UPDATE project 
		SET budget = budget + budget*@percent/100;
	END;

USE sampleABG
EXECUTE increase_budget 10;