Scriptname SL_Dibella_DeadSisterLetter extends ObjectReference  

Quest property DibellaJoinQuest auto

Event OnRead()
; 	;debug.trace(self + "OnRead() WE100ReadLetter = 1")
	
	DibellaJoinQuest.SetStage(21)
	; Debug.Messagebox("I found a letter")

EndEvent