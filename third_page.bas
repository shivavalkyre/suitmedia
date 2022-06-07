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

	Private Label1 As Label
	Private CustomListView1 As CustomListView
	
	
	Private LabelTitle As Label
	Private LabelContent As Label
	Private LabelDate As Label
	Private LabelTime As Label
	Private Label4 As Label
	Private click_status As Int=0
	Private MapFragment1 As MapFragment
	Private gmap As GoogleMap
	Private gmap_extra As GoogleMapsExtras
	Private rp As RuntimePermissions

	Dim MapPanel As Panel
	Private InfoWindowPanel As Panel
	Private LabelTitleInfoWindow As Label
End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:
	Activity.LoadLayout("layout_page3")
	CustomListView1.AsView.Visible=True
	MapPanel .Visible=False
	
	Wait For MapFragment1_Ready
	gmap = MapFragment1.GetMap
	rp.CheckAndRequest(rp.PERMISSION_ACCESS_FINE_LOCATION)
	Wait For Activity_PermissionResult (Permission As String, Result As Boolean)
	If Result Then
		gmap.MyLocationEnabled = False
		gmap_position
	Else
		Log("No permission!")
	End If
	
	For i =1 To 10
		CustomListView1.Add(CreateListEvent(100%x,120dip,"Event " & i),i)
	Next
End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub


Private Sub Label1_Click
	StartActivity(second_page)
	Activity.Finish
End Sub


Sub gmap_position

	Dim LatLng1 As LatLng
	
	LatLng1.Initialize(-6.276072062922738, 106.82460611029386)
	Dim CameraPosition1 As CameraPosition
	CameraPosition1.Initialize(LatLng1.Latitude, LatLng1.Longitude, 16)
	gmap.GetUiSettings
	gmap.MoveCamera(CameraPosition1)
	'gmap.AddMarker(LatLng1.Latitude,LatLng1.Longitude,"Suitmedia")
	Dim bmp As Bitmap
	bmp.Initialize(File.DirAssets,"marker1.png")
	gmap.AddMarker3(LatLng1.Latitude,LatLng1.Longitude,"Suitmedia",bmp)
	
	gmap.GetUiSettings.ZoomControlsEnabled=False
End Sub

Sub CreateListEvent(Width As Int, Height As Int,title_event As String) As Panel
	Dim p As Panel
	p.Initialize("")
	p.SetLayout(0, 0, Width, Height)
	p.LoadLayout("isiEvent")
	LabelTitle.Text= title_event
	LabelContent.Tag=title_event
	LabelDate.Tag=title_event
	LabelTime.Tag=title_event
	Return p
End Sub


Private Sub LabelTitle_Click
	Dim send As Label
	send= Sender
	General.selected_event = send.Text
	'StartActivity(second_page)
	'Activity.Finish
End Sub

Private Sub LabelContent_Click
	Dim send As Label
	send= Sender
	General.selected_event = send.tag
	'StartActivity(second_page)
	'Activity.Finish
End Sub

Private Sub LabelDate_Click
	Dim send As Label
	send= Sender
	General.selected_event = send.Tag
	'StartActivity(second_page)
	'Activity.Finish
End Sub

Private Sub LabelTime_Click
	Dim send As Label
	send= Sender
	General.selected_event = send.Tag
	'StartActivity(second_page)
	'Activity.Finish
End Sub

Private Sub Label4_Click
	If click_status=0 Then
		Label4.Text=Chr(0xF03A)
		click_status=1
		CustomListView1.AsView.Visible=False
		MapPanel.Visible=True
	Else
		Label4.Text= Chr(0xF279)
		CustomListView1.AsView.Visible=True
		MapPanel.Visible=False
		InfoWindowPanel.Visible=False
		click_status=0
	End If
End Sub



Private Sub MapFragment1_MarkerClick (SelectedMarker As Marker) As Boolean 'Return True to consume the click
	InfoWindowPanel.Visible=True
	LabelTitleInfoWindow.Text= General.selected_event
End Sub