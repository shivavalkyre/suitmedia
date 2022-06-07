B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Activity
Version=11
@EndOfDesignText@
#Region  Activity Attributes 
	#FullScreen: False
	#IncludeTitle: True
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.

End Sub

Sub Globals
	'These global variables will be redeclared each time the activity is created.
	'These variables can only be accessed from this module.

	Private Label2 As Label
	Private Button1 As Button
	Private Button2 As Button
End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:
	Dim jo As JavaObject
	Dim window As JavaObject = jo.InitializeContext.RunMethod("getWindow", Null)
	window.RunMethod("addFlags", Array(Bit.Or(0x00000200, 0x08000000)))
	Activity.Height = Activity.Height + 24dip
	General.SetStatusBarColor1(Colors.Black)
	Activity.LoadLayout("layout_page2")
	Label2.Text= General.typed_name & "!"
End Sub

Sub Activity_Resume
	If General.selected_event.Length>0 Then
		Button1.Text= General.selected_event
	End If
	If General.selected_guest.Length>0 Then
		Button2.Text= General.selected_guest
	End If
End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub


Private Sub Button1_Click
	StartActivity(third_page)
End Sub

Private Sub Button2_Click
	StartActivity(forth_page)
End Sub