!classDefinition: #MeasureTest category: #'Measure-Solution'!
TestCase subclass: #MeasureTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 16:18:25'!
test01 
	self assert: MeasureFactory oneMeter = MeasureFactory oneMeter! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 16:19:21'!
test02
	self assert: MeasureFactory oneMeter = MeasureFactory hundredCentimeters! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 16:37:05'!
test03
	self deny: MeasureFactory oneMeter = MeasureFactory oneDollar! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 17:25:04'!
test04
	self assert: MeasureFactory zeroMeters = MeasureFactory zeroDollars! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 17:56:40'!
test05
	self assert: MeasureFactory oneMeter + MeasureFactory oneMeter = MeasureFactory twoMeters! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 18:01:40'!
test06
	self assert: MeasureFactory oneMeter + MeasureFactory oneDollar = MeasureFactory oneMeterAndOneDollar! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 19:37:27'!
test07
	self assert: MeasureFactory oneMeterAndOneDollar + MeasureFactory oneMeter = MeasureFactory twoMetersAndOneDollar! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 19:45:50'!
test08
	self assert: MeasureFactory oneMeter + MeasureFactory oneMeterAndOneDollar = MeasureFactory twoMetersAndOneDollar! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 00:05:01'!
test09
	self assert: MeasureFactory oneMeterAndOneDollar + MeasureFactory oneMeterAndOneGram = MeasureFactory twoMetersOneDollarAndOneGram! !


!classDefinition: #Measure category: #'Measure-Solution'!
Object subclass: #Measure
	instanceVariableNames: 'amount ratio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!Measure methodsFor: 'as yet unclassified' stamp: 'DIC 6/7/2017 23:54:48'!
+ anAdder
	^anAdder addMeasure: self! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 17:54:24'!
= aMeasure
	^(amount = 0 and: [^aMeasure compareWithNoAmount]) or: [(aMeasure isKindOf: self class ) and: [amount * ratio = (aMeasure amount * aMeasure ratio)]]
	! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIC 6/7/2017 23:54:33'!
addMeasure: aMeasure 
	(aMeasure isKindOf: self class) ifFalse: [^MeasureGroup with: self with: aMeasure].
	^aMeasure class withAmount: amount * ratio + (aMeasure amount * aMeasure ratio) withRatio: 1.! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 16:32:16'!
amount
	^amount ! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 17:35:44'!
compareWithNoAmount
	^amount = 0! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 19:04:40'!
hash
	^('{}-{}' format: {self class name, amount asString}) hash! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 16:33:50'!
ratio
	^ratio! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 17:12:01'!
withAmount: anAmount withRatio: aRatio
	amount := anAmount.
	ratio := aRatio.
	^self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Measure class' category: #'Measure-Solution'!
Measure class
	instanceVariableNames: ''!

!Measure class methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 17:13:25'!
withAmount: anAmount withRatio: aRatio 
	^self new withAmount: anAmount withRatio: aRatio! !


!classDefinition: #Currency category: #'Measure-Solution'!
Measure subclass: #Currency
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!


!classDefinition: #Distance category: #'Measure-Solution'!
Measure subclass: #Distance
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Distance class' category: #'Measure-Solution'!
Distance class
	instanceVariableNames: ''!

!Distance class methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 16:55:00'!
withAmount: anAmount withRatio: aRatio 
	^self new withAmount: anAmount withRatio: aRatio! !


!classDefinition: #Mass category: #'Measure-Solution'!
Measure subclass: #Mass
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!


!classDefinition: #MeasureFactory category: #'Measure-Solution'!
Object subclass: #MeasureFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MeasureFactory class' category: #'Measure-Solution'!
MeasureFactory class
	instanceVariableNames: ''!

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 17:08:05'!
hundredCentimeters
	^Distance withAmount:100 withRatio:1/100! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 17:12:42'!
oneDollar
	^Currency withAmount: 1 withRatio: 1! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 00:07:25'!
oneGram
	^Mass withAmount: 1 withRatio: 1! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 17:08:13'!
oneMeter
	^Distance withAmount:1 withRatio:1! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 19:18:51'!
oneMeterAndOneDollar
	^MeasureGroup with: self oneMeter with: self oneDollar! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 00:08:39'!
oneMeterAndOneGram
	^MeasureGroup with: MeasureFactory oneMeter with: MeasureFactory oneGram! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 17:59:19'!
twoMeters
	^Distance withAmount: 2 withRatio: 1.! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 19:22:47'!
twoMetersAndOneDollar
	^MeasureGroup with: self twoMeters with: self oneDollar! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 00:09:54'!
twoMetersOneDollarAndOneGram
	^MeasureGroup with: MeasureFactory twoMeters with: MeasureFactory oneDollar with: MeasureFactory oneGram! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 17:27:34'!
zeroDollars
	^Currency withAmount: 0 withRatio: 1! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 17:26:26'!
zeroMeters
	^Distance withAmount: 0 withRatio: 1.! !


!classDefinition: #MeasureGroup category: #'Measure-Solution'!
Object subclass: #MeasureGroup
	instanceVariableNames: 'contents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!MeasureGroup methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 00:22:48'!
+ anAdder
	(anAdder isKindOf: self class) ifTrue: [
		anAdder contents do: [:aMeasure | self addMeasure: aMeasure].
		^self.
	].
	contents
		at: anAdder class name
		ifPresent: [:existingMeasure | contents at: existingMeasure class name put: existingMeasure + anAdder]
		ifAbsent: [ contents at: anAdder class name put: anAdder ].
	^self.! !

!MeasureGroup methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 19:43:57'!
= aMeasureGroup
	^contents = aMeasureGroup contents! !

!MeasureGroup methodsFor: 'as yet unclassified' stamp: 'DIC 6/7/2017 23:53:13'!
addMeasure: aMeasure 
	^self + aMeasure ! !

!MeasureGroup methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 19:44:12'!
contents
	^contents! !

!MeasureGroup methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 19:58:00'!
initialize
	contents := Dictionary new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MeasureGroup class' category: #'Measure-Solution'!
MeasureGroup class
	instanceVariableNames: ''!

!MeasureGroup class methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 19:21:31'!
with: aMeasure with: anotherMeasure 
	| aMeasureGroup|
	aMeasureGroup :=  self new.
	aMeasureGroup + aMeasure.
	aMeasureGroup + anotherMeasure.
	^aMeasureGroup! !

!MeasureGroup class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 00:11:35'!
with: aMeasure with: anotherMeasure with: yetAnotherMeasure
	| measureGroup |
	measureGroup := self new.
	measureGroup + aMeasure.
	measureGroup + anotherMeasure.
	measureGroup + yetAnotherMeasure.
	^measureGroup! !