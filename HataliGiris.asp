﻿<%@ Language="VBScript" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <title>Hatalı Giriş :S</title>
        <link rel="stylesheet" type="text/css" href="stil.css">
    </head>
    <body>
        <div class="AnaDiv">
            <div class="UstMenu">
                <div id="foto">
                   <a href="index.html"><img src="arkaplan.jpg" alt="tema" height="150px" width="1000px" ></a>
                </div>
                <div id="giris">
                    <%
                         if session("UserLoggedIn") <> "" then
                           ' response.write("<h4>"&"Hoşgeldiniz "&session("UserLoggedIn"))
                    %>
                          <h4 style="color: #ffd800;float: right;margin-right: 30px; text-shadow: 5px 2px 1px #000">Hoşgeldin <%= response.write(session("UserLoggedIn")) %></h4>
                    <%    
                         else
                            if request.form("KullanıcıAd")="admin" or request.form("KullanıcıAd")="Admin" and request.form("KullanıcıSif")="1234" then
                                session("UserLoggedIn")=request.form("KullanıcıAd")
                    %>
                            <h4 style="float: right;margin-right: 20px;color: #ffd800;    text-shadow: 5px 2px 1px #000">Hoşgeldin <%= response.write(request.form("KullanıcıAd"))%></h4>
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
                                    <a href="sifremiunuttum.asp"><span style="margin-left: 160px">Şifremi Unuttum</span></a>
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
                        response.redirect("index.asp")
                        end if
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
                         if session("UserLoggedIn") <> "" then
                            response.write("<hr>")
                            response.write ("<a href='Cikis.asp'>Çıkış Yap!</a>")
                        else
                            response.write("<hr>")
                            response.write("<a href='kayitsayfasi.asp'>Kayıt Ol!</a>")
                        end if
               %>                 
              </center>
            </div>
            <div class="icerik">
                <% if oRS.EOF then%>
                <h1>Hatalı Giriş Yaptınız</h1><br><br>
                <h3>Lütfen Ad Soyad ve Şifreyi Kontrol Edip Tekrar Deneyiniz ve Boş Alan Bırakmayınız</h3>
                <% end if%>
            </div>
        </div>
    </body>
</html>
