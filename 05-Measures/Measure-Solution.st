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

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 00:45:30'!
test10
	self assert: MeasureFactory twoMeters - MeasureFactory hundredCentimeters = MeasureFactory oneMeter ! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 00:53:46'!
test11
	self assert: MeasureFactory oneMeterAndOneDollar - MeasureFactory oneMeter = MeasureFactory zeroMetersAndOneDollar! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 00:56:43'!
test12
	self assert: MeasureFactory oneMeterAndOneDollar - MeasureFactory oneMeterAndOneGram = MeasureFactory zeroMetersMinusOneGramAndOneDollar! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 01:08:37'!
test13
	self assert: MeasureFactory oneMeter * 2 = MeasureFactory twoMeters.
	self assert: 2 * MeasureFactory oneMeter = MeasureFactory twoMeters.! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 01:18:10'!
test14
	self assert: MeasureFactory fourMeters / 2 = MeasureFactory twoMeters.
	self assert: MeasureFactory oneMeter/3 = MeasureFactory oneThirdMeter.! !

!MeasureTest methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 01:43:08'!
test15
	self assert: (MeasureFactory oneMeter convertTo: UnitFactory centimeter) = MeasureFactory hundredCentimeters.! !


!classDefinition: #Measure category: #'Measure-Solution'!
Object subclass: #Measure
	instanceVariableNames: 'amount unit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!Measure methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 02:06:05'!
* aScalar 
	^self class withAmount: amount * aScalar withUnit: unit! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIC 6/7/2017 23:54:48'!
+ anAdder
	^anAdder addMeasure: self! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 00:47:48'!
- aMeasure 
	^self + aMeasure negated! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 02:06:47'!
/ aScalar
	^self class withAmount: (amount / aScalar) asFraction withUnit: unit! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 02:22:57'!
= aMeasure
	^(amount = 0 and: [^aMeasure compareWithNoAmount]) or: [(aMeasure isKindOf: self class ) and: [amount = (aMeasure convertTo: unit) amount]]
	! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 01:12:58'!
adaptToNumber: aScalar andSend: aSymbol 
	^self perform: aSymbol with: aScalar! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 02:10:35'!
addMeasure: aMeasure
	| convertedMeasure |
	(aMeasure isKindOf: self class) ifFalse: [^MeasureGroup with: self with: aMeasure].
	convertedMeasure := aMeasure convertTo: unit.
	^aMeasure class withAmount: amount + convertedMeasure amount withUnit: unit.! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 00:35:55'!
addToMeasureGroup: aMeasureGroup
	^aMeasureGroup addMeasure: self! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 16:32:16'!
amount
	^amount ! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 17:35:44'!
compareWithNoAmount
	^amount = 0! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 02:23:34'!
convertTo: anUnit 
	(anUnit measures: self class) ifFalse: [self error: 'Cant convert to unrelated unit'].
	^self class withAmount: (amount * unit ratio / anUnit ratio) asFraction withUnit: anUnit! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 19:04:40'!
hash
	^('{}-{}' format: {self class name, amount asString}) hash! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 02:11:07'!
negated
	^self class withAmount: amount negated withUnit: unit! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 16:33:50'!
ratio
	^ratio! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 01:03:30'!
removeFromMeasureGroup: aMeasureGroup
	^aMeasureGroup addMeasure: self negated! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 17:12:01'!
withAmount: anAmount withRatio: aRatio
	amount := anAmount.
	ratio := aRatio.
	^self! !

!Measure methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 02:20:11'!
withAmount: anAmount withUnit: anUnit 
	amount := anAmount.
	unit := anUnit.
	^self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Measure class' category: #'Measure-Solution'!
Measure class
	instanceVariableNames: ''!

!Measure class methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 17:13:25'!
withAmount: anAmount withRatio: aRatio 
	^self new withAmount: anAmount withRatio: aRatio! !

!Measure class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 02:11:48'!
withAmount: anAmount withUnit: anUnit
	^self new withAmount: anAmount withUnit: anUnit! !


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

!Distance class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 02:05:37'!
withAmount: anAmount withUnit: anUnit
	^self new withAmount: anAmount withUnit: anUnit! !


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

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 02:13:16'!
fourMeters
	^Distance withAmount: 4 withUnit: UnitFactory meter! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 02:14:37'!
hundredCentimeters
	^Distance withAmount: 100 withUnit: UnitFactory centimeter! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 02:15:25'!
oneDollar
	^Currency withAmount: 1 withUnit: UnitFactory dollar! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 02:16:57'!
oneGram
	^Mass withAmount: 1 withUnit: UnitFactory gram! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 02:16:50'!
oneMeter
	^Distance withAmount: 1 withUnit: UnitFactory meter! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 19:18:51'!
oneMeterAndOneDollar
	^MeasureGroup with: self oneMeter with: self oneDollar! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 00:08:39'!
oneMeterAndOneGram
	^MeasureGroup with: MeasureFactory oneMeter with: MeasureFactory oneGram! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 02:16:43'!
oneThirdMeter
	^Distance withAmount: 1/3 withUnit: UnitFactory meter! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 02:17:11'!
twoMeters
	^Distance withAmount: 2 withUnit: UnitFactory meter.! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 19:22:47'!
twoMetersAndOneDollar
	^MeasureGroup with: self twoMeters with: self oneDollar! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 00:09:54'!
twoMetersOneDollarAndOneGram
	^MeasureGroup with: MeasureFactory twoMeters with: MeasureFactory oneDollar with: MeasureFactory oneGram! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 02:17:28'!
zeroDollars
	^Currency withAmount: 0 withUnit: UnitFactory dollar! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 02:17:53'!
zeroMeters
	^Distance withAmount: 0 withUnit: UnitFactory meter.! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 00:55:17'!
zeroMetersAndOneDollar
	^MeasureGroup with: self zeroMeters with: self oneDollar! !

!MeasureFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 00:59:43'!
zeroMetersMinusOneGramAndOneDollar
	^MeasureGroup with: self zeroMeters with: self oneGram negated with: self oneDollar! !


!classDefinition: #MeasureGroup category: #'Measure-Solution'!
Object subclass: #MeasureGroup
	instanceVariableNames: 'contents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!MeasureGroup methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 00:35:30'!
+ anAdder
	^anAdder addToMeasureGroup: self! !

!MeasureGroup methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 01:27:03'!
- anAdder
	^anAdder removeFromMeasureGroup: self.! !

!MeasureGroup methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 19:43:57'!
= aMeasureGroup
	^contents = aMeasureGroup contents! !

!MeasureGroup methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 00:34:59'!
addMeasure: aMeasure 
	contents
		at: aMeasure class name
		ifPresent: [:existingMeasure | contents at: existingMeasure class name put: existingMeasure + aMeasure]
		ifAbsent: [ contents at: aMeasure class name put: aMeasure ].
	^self.! !

!MeasureGroup methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 00:33:28'!
addToMeasureGroup: aMeasureGroup
	self contents do: [:aMeasure | aMeasureGroup addMeasure: aMeasure].
	^aMeasureGroup .! !

!MeasureGroup methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 19:44:12'!
contents
	^contents! !

!MeasureGroup methodsFor: 'as yet unclassified' stamp: 'DIC 6/3/2017 19:58:00'!
initialize
	contents := Dictionary new.! !

!MeasureGroup methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 01:02:35'!
removeFromMeasureGroup: aMeasureGroup
	self contents do: [:aMeasure | aMeasureGroup addMeasure: aMeasure negated].
	^aMeasureGroup .! !

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


!classDefinition: #Unit category: #'Measure-Solution'!
Object subclass: #Unit
	instanceVariableNames: 'unitName measure ratio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!Unit methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 01:53:58'!
measures: aMeasureClass 
	^measure = aMeasureClass ! !

!Unit methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 01:54:12'!
ratio
	^ratio ! !

!Unit methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 01:48:51'!
withName: aString ofMeasure: aMeasureClass withRatio: ratioToBaseUnit 
	unitName := aString.
	measure := aMeasureClass.
	ratio := ratioToBaseUnit.
	^self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Unit class' category: #'Measure-Solution'!
Unit class
	instanceVariableNames: ''!

!Unit class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 01:47:28'!
named: aString of: aMeasureClass withRatio: ratioToBaseUnit
	^self new withName: aString ofMeasure: aMeasureClass withRatio: ratioToBaseUnit! !


!classDefinition: #UnitFactory category: #'Measure-Solution'!
Object subclass: #UnitFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'UnitFactory class' category: #'Measure-Solution'!
UnitFactory class
	instanceVariableNames: ''!

!UnitFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 01:44:33'!
centimeter
	^Unit named: 'centimeter' of:Distance withRatio: 1/100! !

!UnitFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 02:24:22'!
dollar
	^Unit named: 'dollar' of: Currency withRatio: 1! !

!UnitFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 02:25:19'!
gram
	^Unit named: 'gram' of: Mass withRatio: 1! !

!UnitFactory class methodsFor: 'as yet unclassified' stamp: 'DIC 6/8/2017 02:19:22'!
meter
	^Unit named: 'meter' of: Distance withRatio: 1! !
