﻿<%@ Language="VBScript" %>
<!DOCTYPE html>

<html lang="en">
    <head>
        <meta charset="utf-8" />
        <title>	Ayşegül Bulur Fotoğraf</title>
        <link rel="stylesheet" href="stil.css" type="text/css">
    </head>
    <body>
        <div class="AnaDiv">
            <div class="UstMenu">
                <div id="foto">
                    <a href="index.html"><img src="arkaplan.jpg" alt="tema" height="150px" width="1000px" ></a>
                </div>
                <div id="giris">
                    <%   
                         If Request.QueryString("Sayfa") = "" Then
	                         sayfa = 1
                        Else
	                          sayfa = cInt(Request.QueryString("Sayfa"))
                        end if
                           
                         if session("UserLoggedIn") <> "" then
                           ' response.write("<h4>"&"Hoşgeldiniz "&session("UserLoggedIn"))
                    %>
                          <h4 style="color: #ffd800;float: right;margin-right: 30px; text-shadow: 5px 2px 1px #000">Hoşgeldin <%=response.write(session("UserLoggedIn"))%></h4>
                    <%    
                         else
                            dim username,sifre
                            Set oConn = Server.CreateObject("ADODB.Connection")
                            oConn.Open("DRIVER={Microsoft Access Driver (*.mdb)}; DBQ=" & Server.MapPath("database.mdb"))
                            ssql="select Ad+' '+Soyad,Sifre from Kullanıcı_Bilgileri where Ad+' '+Soyad='" & request.form("KullanıcıAd")& "' and Sifre='"& request.form("KullanıcıSif")&"';"
                            Set oRS = oConn.Execute(sSQL)     
                           
                            if oRS.EOF then
                    %>
                        <form action="index.asp" method="post">
                        <table style="width: 100%;height: 90%;margin-top: 10px" border="0" >
                            <tr>
                                <td style="width: 110px">
                                    <span>Ad Soyad</span>
                                    <br>
                                    <input type="text" style="border-radius: 10px" name="KullanıcıAd">   
                                </td>
                                <td style="width: 170px">
                                    Şifre
                                    <br>
                                     <input type="password" style="border-radius: 10px" name="KullanıcıSif">
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <a href="sifremiunuttum.html"><span style="margin-left: 160px">Şifremi Unuttum</span></a>
                                    <a href=""><input type="submit" value="Giriş Yap" style="color:  #d25313;margin-left: 20px;"></a>  
                                </td>
                            </tr>
                    
                        </table>
                        </form>
                    <% 
                        else             
                    %>
                    <h4 style="float: right;margin-right: 20px;color: #ffd800;    text-shadow: 5px 2px 1px #000">Hoşgeldin <%= response.write(request.form("KullanıcıAd"))%></h4>
                    <%
                        Session("UserLoggedIn") =request.form("KullanıcıAd")
                        end if
                        end if
                    %>

                </div>
                <span style=" font-family: 'Times New Roman'; padding-left:100px; font-size: 45px;  font:bold 30px tahoma;  color: #000000; text-align: center"><i>Necip Fazıl Anadolu Lisesi</i></span> 
            </div>
            <div class="SolMenu">
             <center>
                 <br>
                 <a href="index.asp">Ana Sayfa</a>
                 <hr>
                 <a href="kisiler.asp">Kişiler</a>
                 <hr>
                 <a href="Fotolar.asp">Fotoğraflar</a>
                 <hr>
                 <a href="video.asp">Videolar</a>
                 <hr>
                 <a href="kimnerde.asp">Kim,Nerde,Ne Yapıyor?</a>
                 <hr>
                 <a href="Forum.asp">Forum</a>
                 <hr>
                 <a href="Harita.asp">Harita</a>
                 <hr>
                 <a href="KisiAra.asp">Ara</a>
                 <%
                         if session("UserLoggedIn") <> " " then
                            response.write("<hr>")
                            response.write ("<a href='Cikis.asp'>Çıkış Yap!</a>")
                        else
                            response.write("<hr>")
                            response.write("<a href='kayitsayfasi.html'>Kayıt Ol!</a>")
                        end if

                     %>                   
               </center>   
            </div>
            <div class="icerik">
                <%
                dim saat_tr
                'Şu anki USA saatini yerel saate cevirme:
                sat = split(time(),":",-1,1)
                tarih = split(date(),"/",-1,1)
                if right(time(),2)="PM" and sat(0)<>12 then
                sat(0) = sat(0) + 12
                end if
                sat(0) = sat(0) + 7
                if sat(0)>=24 then
                sat(0)=sat(0)-24
                end if
                saat_tr = Date()&" "& sat(0) & ":" & sat(1) & ":" & left(sat(2),2)    
                
                dim tut
                'VT baglantisinin yapimasi:
                Set Baglantim = CreateObject("ADODB.Connection") 
                'VT'nin acilmasi:
                Baglantim.Open ("DRIVER={Microsoft Access Driver (*.mdb)};DBQ="& Server.MapPath("database.mdb"))
                'Tablo nesnesinin olusturulmasi:
                Set Tablom = server. CreateObject("ADODB.Recordset")
                'Tablonun acilmasi:
                Tablom.Open "foto2", Baglantim, 1, 3      
                'Tabloya veri eklemeye baslangic:
                Tablom.Addnew
                'Tablodaki alanlara veri 
                Set ara = Baglantim.Execute("Select Yorum from foto2")
                Do While NOT ara.EOF
                    if ara("Yorum")=request.form("yorum") then
                        tut=" "
                    end if
                     ara.MoveNext
                loop
                if tut <> " " then             
                    Tablom("Kullanıcı_Adı") = session("UserLoggedIn")
                    Tablom("Yorum") = request.form("yorum")
                    Tablom("Tarih") = saat_tr
                end if
                'aktarma islemi birince tablonun guncellenmesi:
                Tablom.Update
                Tablom.close
                set Tablom= Nothing
                Baglantim.close
                set Baglantim= Nothing         
            
            %>
                <table style="margin-left: 20px;margin-top: 50px;float: left" border="0">
                <tr>
                    <td rowspan="5"><img src="fotograflar2.jpg" alt="arkadaş" width="350px" height="350px"></td>
                    <td style="width: 28%"><b>Fotoğrafı Paylaşan Kişi:</b></td>
                    <td>Ayşegül Bulur</td>
                </tr>
                 <tr>
                    <td style="width: 28%"><b>Yanındakiler:</b></td>
                    <td>Aleyna,Kadriye,Hamza,Bilal,Hande B.,Hande E.</td>
                </tr>
                <tr>
                    <td><b>Fotoğraf'ın Çekildiği Tarih:</b></td>
                    <td>29.02.2014</td>
                </tr>
                <tr>
                    <td><b> Fotoğraf'ın Paylaşıldığı Tarih:</b></td>
                    <td>08.06.2018 18:57</td>
                </tr>
                <tr>
                    <td><b>Fotoğraf Açıklaması:</b></td>
                    <td>Ders molası</td>
                </tr>
            </table>
                <%
        
                    Set Conn = Server.CreateObject("ADODB.Connection")
                    Conn.Open("DRIVER={Microsoft Access Driver (*.mdb)}; DBQ=" & Server.MapPath("database.mdb"))
                    ssql="select * from foto2 where Kullanıcı_Adı IS NOT NULL and Yorum IS NOT NULL and Tarih IS NOT NULL  order by Tarih ;"
                    set say = Conn.Execute(sSQL)
                    
                    do while not say.eof
                        a=a+1
                        say.movenext
                    loop
                    set say = nothing
                    if a=0 then
                          sayfa=0
                    end if
                    sonsayfa=(int((a-1)/10))+1

                    Set RS = Conn.Execute(sSQL)
                %>
            <table style="width: 95%;margin-left: 20px;margin-top: 30px;" border="1" class="tablo">
                <tr>
                    <th style="width: 25%">Kullanıcı Adı</th>
                    <th style="width: 50%">Yorum</th>
                    <th style="width: 25%">Tarih</th>
                </tr>
                <%
                    Do While NOT RS.EOF
                    i=i+1
                    if i>=((sayfa-1)*10)+1 and i<=sayfa*10 then   
                %>
                <tr>
                    <td><%=RS("Kullanıcı_Adı")%></td>
                    <td><%=RS("Yorum")%></td>
                    <td><%=RS("Tarih")%></td>
                </tr>
                <%	
	                end if
                        RS.MoveNext
                    Loop
                
                    Conn.Close
                    Set RS = Nothing
                    Set Conn = Nothing
                %>
           </table>
           <center>
                <%
                    if sayfa>1 then
                %>
                    <a href="fotoesra.asp?Sayfa=<%=1%>"><B>|< İlk Sayfa </B></a>
                    <a href="fotoesra.asp?Sayfa=<%=sayfa-1%>"><span style="margin-left: 5px"><b>< Önceki Sayfa</b></span></a>
                <% end if%>
                    <span style="margin-left: 5px"><b> <%=sayfa%> / <%=sonsayfa%> </b></span>
                <%
                    if sonsayfa<>sayfa then
                %>
                    <a href="fotoesra.asp?sayfa=<%=sayfa+1%>"><span style="margin-left: 5px"><b>Sonraki Sayfa></b></span></a>
                    <a href="fotoesra.asp?sayfa=<%=sonsayfa%>"><span style="margin-left: 5px"><b>Son Sayfa >|</b></span></a>
               <%end if%>
            </center> 
           <center>
                <form action="fotoesra.asp" method="post">
                <h2>Fotoğraf İle İlgili Hatıranı Paylaş</h2>
                <textarea rows="15" cols="60" name="yorum"></textarea><br>
                <input type="submit" width="40px" value="Paylaş" style="margin-bottom: 20px;color: #d25313">
                 </form>
            </center>
                veritabanındaki kayıt sayısı:<%=i%>
            </div>
        </div>
        <%
            if session("UserLoggedIn") = "" then
                response.redirect("Login.asp")
             end if
        %>
    </body>
</html>
