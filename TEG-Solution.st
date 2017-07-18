!classDefinition: #TEGtests category: #'TEG-Solution'!
TestCase subclass: #TEGtests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TEG-Solution'!

!TEGtests methodsFor: 'as yet unclassified' stamp: 'ARM 7/18/2017 09:16:26'!
test01cantCreateADiceWithLessThanTwoFaces
	self should: [Dice createDiceWithNumberOfFaces: 1]  
		  raise: Error - MessageNotUnderstood  
		  withExceptionDo: [:anError | self assert: 'Dice cant have less than two faces' equals: anError messageText ]
	! !

!TEGtests methodsFor: 'as yet unclassified' stamp: 'ARM 7/18/2017 09:15:14'!
test02cantCreateADiceWithANonIntegerValueOfFaces
	self should: [Dice createDiceWithNumberOfFaces: 2.2]  
		  raise: Error - MessageNotUnderstood  
		  withExceptionDo: [:anError | self assert: 'Dice cant have a non integer number of faces' equals: anError messageText ]
	! !

!TEGtests methodsFor: 'as yet unclassified' stamp: 'ARM 7/18/2017 10:00:00'!
test03AnArmyCantCreateArmyWithStrenghtLessThanOne	

	self should: [Army createArmyWithStrenght:0 fromPlayer: 1]  
		  raise: Error - MessageNotUnderstood  
		  withExceptionDo: [:anError | self assert: 'cant have an army with less than 1 strenght' equals: anError messageText ]! !

!TEGtests methodsFor: 'as yet unclassified' stamp: 'ARM 7/18/2017 10:00:13'!
test04AnArmyCantAttackHisOwnPlayersArmies	
	| anArmy |
	anArmy  := Army createArmyWithStrenght: 4 fromPlayer: 1.

	self should: [anArmy attacks: anArmy]  
		  raise: Error - MessageNotUnderstood  
		  withExceptionDo: [:anError | self assert: 'you cant attack your allies idiot' equals: anError messageText ]! !

!TEGtests methodsFor: 'as yet unclassified' stamp: 'ARM 7/18/2017 10:33:11'!
test05AnAttackerWinsOverADefenderOnlyIfItHasMoreStrenght
	| attackerArmy defenderArmy |
	
	attackerArmy  := Army createArmyWithStrenght: 4 fromPlayer: 1.
	defenderArmy := Army createArmyWithStrenght: 3 fromPlayer: 2.
	
	self assert: (attackerArmy attacks: defenderArmy) equals: defenderArmy player! !

!TEGtests methodsFor: 'as yet unclassified' stamp: 'ARM 7/18/2017 11:19:00'!
test06cantCreateACombatWithNorAttackingArmies

	| attackerArmies defenderArmies |
	
	attackerArmies := OrderedCollection new.
	defenderArmies := OrderedCollection new.
	
	self should: [Combat createCombatWithAttackerArmies: attackerArmies withDefendingArmies: defenderArmies]  
		  raise: Error - MessageNotUnderstood  
		  withExceptionDo: [:anError | self assert: 'must have more than 0 attacker Armies' equals: anError messageText ]! !

!TEGtests methodsFor: 'as yet unclassified' stamp: 'ARM 7/18/2017 11:23:22'!
test07cantCreateACombatWithNorDefenderArmies

	| attackerArmies defenderArmies |
	
	attackerArmies := OrderedCollection new.
	attackerArmies add: (Army createArmyWithStrenght: 4 fromPlayer: 1 ). 
	defenderArmies := OrderedCollection new.
	
	self should: [Combat createCombatWithAttackerArmies: attackerArmies withDefendingArmies: defenderArmies]  
		  raise: Error - MessageNotUnderstood  
		  withExceptionDo: [:anError | self assert: 'must have more than 0 defender Armies' equals: anError messageText ]! !

!TEGtests methodsFor: 'as yet unclassified' stamp: 'ARM 7/18/2017 14:03:07'!
test08ExecutingACombatReturnsTheAmountOfArmiesThatTheAtkAndDefLost

	| attackerArmies defenderArmies combat |
	
	attackerArmies := OrderedCollection new.
	attackerArmies add: (Army createArmyWithStrenght: 4 fromPlayer: 1 ). 
	defenderArmies := OrderedCollection new.
	defenderArmies add: (Army createArmyWithStrenght: 3 fromPlayer: 1 ).
	combat := Combat createCombatWithAttackerArmies: attackerArmies withDefendingArmies: defenderArmies.
	
	self assert: combat execute equals: 'El atacante pierde 0 ejércitos y el defensor pierde 1.'
	! !


!classDefinition: #Army category: #'TEG-Solution'!
Object subclass: #Army
	instanceVariableNames: 'armyStrenght armysPlayer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TEG-Solution'!

!Army methodsFor: 'as yet unclassified' stamp: 'ARM 7/18/2017 10:35:23'!
attacks: anArmy 
	self player = anArmy player ifTrue: [^self error: 'you cant attack your allies idiot'].
	armyStrenght > anArmy strenght ifTrue: [^anArmy player].
	^armysPlayer.
	! !

!Army methodsFor: 'as yet unclassified' stamp: 'ARM 7/18/2017 09:49:43'!
initializeArmyWithStrenght: anArmyStrenght fromPlayer: aPlayer 
	armyStrenght := anArmyStrenght .
	armysPlayer := aPlayer .
	^self.! !

!Army methodsFor: 'as yet unclassified' stamp: 'ARM 7/18/2017 09:55:24'!
player
	^armysPlayer ! !


!Army methodsFor: 'accessing' stamp: 'ARM 7/18/2017 10:34:34'!
strenght
	^armyStrenght ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Army class' category: #'TEG-Solution'!
Army class
	instanceVariableNames: ''!

!Army class methodsFor: 'initialization' stamp: 'ARM 7/18/2017 10:04:14'!
createArmyWithStrenght: anArmyStrenght fromPlayer: aPlayer 
	anArmyStrenght < 1 ifTrue: [^self error: 'cant have an army with less than 1 strenght']. 
	^self new initializeArmyWithStrenght: anArmyStrenght  fromPlayer: aPlayer.! !


!classDefinition: #Combat category: #'TEG-Solution'!
Object subclass: #Combat
	instanceVariableNames: 'attackerArmy defenderArmy'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TEG-Solution'!

!Combat methodsFor: 'as yet unclassified' stamp: 'ARM 7/18/2017 14:13:15'!
execute
	^self! !

!Combat methodsFor: 'as yet unclassified' stamp: 'ARM 7/18/2017 14:11:08'!
initializeCombatWithAttackerArmies: anAttackerArmy withDefendingArmies: aDefenderArmy 
	attackerArmy := anAttackerArmy.
	defenderArmy := aDefenderArmy.
	^self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Combat class' category: #'TEG-Solution'!
Combat class
	instanceVariableNames: ''!

!Combat class methodsFor: 'initialization' stamp: 'ARM 7/18/2017 14:12:34'!
createCombatWithAttackerArmies: anAttackerArmies withDefendingArmies: aDefenderArmies 
	anAttackerArmies isEmpty ifTrue: [^self error: 'must have more than 0 attacker Armies'].
	aDefenderArmies isEmpty ifTrue: [^self error: 'must have more than 0 defender Armies'].
	
	^self new initializeCombatWithAttackerArmies: anAttackerArmies withDefendingArmies: aDefenderArmies.! !



!classDefinition: #Dice category: #'TEG-Solution'!
Object subclass: #Dice
	instanceVariableNames: 'numberOfFaces'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TEG-Solution'!

!Dice methodsFor: 'as yet unclassified' stamp: 'ARM 7/16/2017 23:10:35'!
initializeWithNumberOfFaces: aNumberOfFaces
	numberOfFaces := aNumberOfFaces .
	^self.! !

!Dice methodsFor: 'as yet unclassified' stamp: 'ARM 7/16/2017 23:14:51'!
roll
	^Random nextInteger: numberOfFaces.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Dice class' category: #'TEG-Solution'!
Dice class
	instanceVariableNames: ''!

!Dice class methodsFor: 'initialization' stamp: 'ARM 7/16/2017 23:24:52'!
createDiceWithNumberOfFaces: aNumberOfFaces
	(aNumberOfFaces  isKindOf: Integer) ifFalse: [^self error: 'Dice cant have a non integer number of faces'].
	aNumberOfFaces < 2 ifTrue: [^self error: 'Dice cant have less than two faces'].
	^self new initializeWithNumberOfFaces: aNumberOfFaces.! !
