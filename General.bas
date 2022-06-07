B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=11
@EndOfDesignText@
'Code module
'Subs in this code module will be accessible from all modules.
Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Dim typed_name As String
	Dim last_image As Bitmap
	Dim selected_event As String
	dim selected_guest as String
End Sub


Sub SetBackgroundTintList(View As View,Active As Int, Enabled As Int)
	Dim States(2,1) As Int
	States(0,0) = 16842908     'Active
	States(1,0) = 16842910    'Enabled
	Dim Color(2) As Int = Array As Int(Active,Enabled)
	Dim CSL As JavaObject
	CSL.InitializeNewInstance("android.content.res.ColorStateList",Array As Object(States,Color))
	Dim jo As JavaObject
	jo.InitializeStatic("android.support.v4.view.ViewCompat")
	jo.RunMethod("setBackgroundTintList", Array(View, CSL))
End Sub



Sub SetStatusBarColor(clr As Int)
	Dim p As Phone
	If p.SdkVersion > 20 Then

		'Background color
		Dim jo As JavaObject
		jo.InitializeContext
		Dim window As JavaObject = jo.RunMethodJO("getWindow", Null)
		window.RunMethod("addFlags", Array (0x80000000))
		window.RunMethod("clearFlags", Array (0x04000000))
		window.RunMethod("setStatusBarColor", Array(clr))
 
		Dim view As JavaObject = window.RunMethodJO("getDecorView",Null)

		'view.RunMethod("setSystemUiVisibility",Array(Bit.Or(0x00002000,view.RunMethod("getSystemUiVisibility",Null)))) 'Light style with black icons and text
		view.RunMethod("setSystemUiVisibility",Array(0)) 'Dark style with White icons and text
	End If
End Sub

Sub SetStatusBarColor1(clr As Int)
	Dim p As Phone
	If p.SdkVersion > 20 Then

		'Background color
		Dim jo As JavaObject
		jo.InitializeContext
		Dim window As JavaObject = jo.RunMethodJO("getWindow", Null)
		window.RunMethod("addFlags", Array (0x80000000))
		window.RunMethod("clearFlags", Array (0x04000000))
		window.RunMethod("setStatusBarColor", Array(clr))
 
		Dim view As JavaObject = window.RunMethodJO("getDecorView",Null)

		view.RunMethod("setSystemUiVisibility",Array(Bit.Or(0x00002000,view.RunMethod("getSystemUiVisibility",Null)))) 'Light style with black icons and text
		' view.RunMethod("setSystemUiVisibility",Array(0)) 'Dark style with White icons and text
	End If
End Sub