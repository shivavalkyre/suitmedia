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
	Private ImageView1 As ImageView
	Private ImageView2 As ImageView
	Private LabelGuest1 As Label
	Private LabelGuest2 As Label
	Private Panel1 As Panel
	Private Panel2 As Panel
	Dim bmp As Bitmap
	Dim nativeMe As JavaObject
End Sub

Sub Activity_Create(FirstTime As Boolean)
	'Do not forget to load the layout file created with the visual designer. For example:
	Activity.LoadLayout("Layout_page4")
	bmp.Initialize(File.DirAssets,"logo_mobile.png")
	GetGuestData
End Sub

Sub Activity_Resume

End Sub

Sub Activity_Pause (UserClosed As Boolean)

End Sub


Private Sub Label1_Click
	Activity.Finish
End Sub

Sub GetGuestData
	Dim j As HttpJob
	j.Initialize("j", Me)
	Dim url As String="https://reqres.in/api/users?page=1&per_page=10"
	j.Download(url)
	
	Wait For (j) JobDone(j As HttpJob)
	If j.Success Then
		Log(j.GetString)
		Dim GuestData As Map
		GuestData.Initialize
		
		Dim result As String= j.GetString
		Dim parser As JSONParser
		parser.Initialize(result)
		Dim jRoot As Map = parser.NextObject
		Dim per_page As Int = jRoot.Get("per_page")
		Dim total As Int = jRoot.Get("total")
		Dim Data As List = jRoot.Get("data")
		Dim i As Int =1
		
		For Each coldata As Map In Data
			Dim last_name As String = coldata.Get("last_name")
			Dim id As Int = coldata.Get("id")
			Dim avatar As String = coldata.Get("avatar")
			Dim first_name As String = coldata.Get("first_name")
			Dim email As String = coldata.Get("email")
			
			
			If Data.Size Mod 2 = 0 Then
				'Data Guset Genap
				If i=2 Then
					GuestData.Put ("id2",id)
					GuestData.Put("first_name2",first_name)
					GuestData.Put("last_name2",last_name)
					GuestData.Put("email2",email)
					GuestData.Put("avatar2",avatar)
					CustomListView1.Add(CreateListItemGuest(100%x,120dip,GuestData),i)
					i=1
				Else
					GuestData.Put ("id1",id)
					GuestData.Put("first_name1",first_name)
					GuestData.Put("last_name1",last_name)
					GuestData.Put("email1",email)
					GuestData.Put("avatar1",avatar)
					i=i+1
				End If
			Else
				'Data Guest Ganjil
			End If
		Next
		Dim page As Int = jRoot.Get("page")
		Dim total_pages As Int = jRoot.Get("total_pages")
		Dim support As Map = jRoot.Get("support")
		Dim text As String = support.Get("text")
		Dim url As String = support.Get("url")
	End If
	j.Release
End Sub




Sub CreateListItemGuest(Width As Int, Height As Int, data_guest As Map) As B4XView
	Dim p As Panel
	p.Initialize("")
	p.SetLayout(0, 0, Width, Height)
	p.LoadLayout("isiGuest")
	
	'Gambar 1
	LabelGuest1.Text = data_guest.Get("first_name1") &" " & data_guest.Get("last_name1")
	
	ImageView1.Tag = data_guest.Get("id1")
	DownloadGambar(data_guest.Get("avatar1"),data_guest.Get("id1"))
	ImageView1.Bitmap =  bmp
		
	If data_guest.Get("id2") ="hidden" Then
		'Gambar 2
		Panel2.Visible = False
		ImageView2.Tag ="hidden"
	Else
		ImageView2.Tag = data_guest.Get("id2")
		LabelGuest2.Text = data_guest.Get("first_name2") &" " & data_guest.Get("last_name2")
		DownloadGambar(data_guest.Get("avatar2"), data_guest.Get("id2"))
		ImageView2.Bitmap =  bmp
		Panel2.Visible = True
	End If
	
	Return p
End Sub


Sub DownloadGambar(nama_gambar As String,counter As Int)
	' download gambar1
	Dim url_gambar1 As String =  nama_gambar
	'Log(url_gambar1)
	Dim g As HttpJob
	g.Initialize("g", Me)
	g.Tag=counter
	g.Download(url_gambar1)
	
End Sub


Sub JobDone(job As HttpJob)
	If job.Success Then
		Dim vNumber As Int
		Dim jNumber As Int
		
		bmp.Initialize3(job.GetBitmap)
		'Log("CLV Size: " & CustomListView1.Size)
		For i=0 To CustomListView1.Size-1
			For Each v As View In CustomListView1.GetPanel(i).GetAllViewsRecursive
				If v Is ImageView Then
					'Log("Tag Image:" & v.Tag)
					'Log("Job Tag:" & job.Tag)
					If v.Tag<> "hidden" Then
						vNumber=v.Tag
						jNumber=job.Tag
				
						If vNumber = jNumber Then
							'Log("Here")
							'v.SetBackgroundImage(bmp)
							Dim bm, bm1 As Bitmap
							bm.Initialize3(bmp)
							Dim borderWidth1 As Int = 50
							Dim borderColor1 As Int = Colors.LightGray
							nativeMe.InitializeContext
							bm1 = nativeMe.RunMethod("getRoundBitmap",Array(bm,borderColor1, borderWidth1))
							v.SetBackgroundImage(bm1)
						End If
				
					End If
				End If
			Next
		Next
	Else
		Log("Error: " & job.ErrorMessage)
	End If
	job.Release
End Sub





Private Sub LabelGuest1_Click
	Dim send As Label
	send = Sender
	Log(send.Text )
	General.selected_guest= send.Text
	StartActivity(second_page)
	Activity.Finish
End Sub

Private Sub LabelGuest2_Click
	Dim send As Label
	send = Sender
	Log(send.Text)
	General.selected_guest= send.Text
	StartActivity(second_page)
	Activity.Finish
End Sub



#If Java

import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Path;
import android.graphics.Rect;
import android.graphics.RectF;
import android.graphics.drawable.BitmapDrawable;
import android.graphics.drawable.Drawable;
import android.graphics.Path.FillType;
import android.graphics.Paint;
import android.graphics.Color;
import android.view.View;

import android.annotation.SuppressLint;
import android.content.Context;
import android.graphics.BitmapShader;
import android.graphics.Shader;
import android.graphics.PorterDuffXfermode;
import android.graphics.PorterDuff.Mode;


public static Bitmap getRoundBitmap(Bitmap scaleBitmapImage, int borderColor, int borderWidth) {
    int targetWidth = 1000;
    int targetHeight = 1000;
    int radius = Math.min((targetHeight - 5)/2, (targetWidth - 5)/2);  
   
    Bitmap targetBitmap = Bitmap.createBitmap(targetWidth, targetHeight,
            Bitmap.Config.ARGB_8888);

    Canvas canvas = new Canvas(targetBitmap);
    Path path = new Path();
    path.addCircle(((float) targetWidth - 1) / 2,
            ((float) targetHeight - 1) / 2,
            (Math.min(((float) targetWidth), ((float) targetHeight)) / 2),
            Path.Direction.CCW);

    canvas.clipPath(path);
   
    Bitmap sourceBitmap = scaleBitmapImage;
   
    canvas.drawBitmap(sourceBitmap, new Rect(0, 0, sourceBitmap.getWidth(),
            sourceBitmap.getHeight()), new Rect(0, 0, targetWidth,
            targetHeight), null);
           
           
    Paint p = new Paint();                                             
    p.setAntiAlias(true);                  
    //    canvas.drawBitmap(sourceBitmap, 4, 4, p);                                     
    p.setXfermode(null);                                               
    p.setStyle(Paint.Style.STROKE);                                          
    p.setColor(borderColor);                                           
    p.setStrokeWidth(borderWidth);                                               
    canvas.drawCircle((targetWidth / 2) , (targetHeight / 2) , radius, p);                             

    return targetBitmap;
}   
   
    public static Bitmap addSquareBorder(Bitmap bmp, int borderSize, int bordercolor) {
           
        Bitmap bmpWithBorder = Bitmap.createScaledBitmap(bmp, bmp.getWidth() + borderSize * 2, bmp.getHeight() + borderSize * 2, false);           
           
        Canvas canvas = new Canvas(bmpWithBorder);
        canvas.drawColor(bordercolor);
        canvas.drawBitmap(bmp, borderSize, borderSize, null);
        return bmpWithBorder;
    }   
   
   


#End If




