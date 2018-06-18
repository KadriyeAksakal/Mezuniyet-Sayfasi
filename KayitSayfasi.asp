﻿<%@ Language="VBScript" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <title>Kayıt Sayfası</title>
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
                 <hr>
                 <a href="Kayitsayfasi.asp">Kayıt Ol!</a>
               </center>   
            </div>
            <div class="icerik">
                <center>
                   <form action="KayitTamam.asp" method="post">
                   <fieldset style="margin-left: 150px;margin-right: 150px; margin-top:60px">
                     <legend><b> Kayıt Formu</b></legend>
                        <table border="0" style="margin-top: 20px">
                        <tr>
                            <td><b> *Adınız:</b></td>
                            <td><input type="text" placeholder="Adı giriniz" name="isim"></td>
                        </tr>
                        <tr><td colspan="2" style="height: 5px"></td></tr>
                        <tr>
                            <td><b>*Soyadınız:</b></td>
                            <td><input type="text" name="soyisim"></td>
                        </tr>
                        <tr><td colspan="2" style="height: 5px"></td></tr>
                        <tr>
                            <td><b>*Yaşınız:</b></td>
                            <td><input type="number" name="yas"></td>
                        </tr>
                        <tr><td colspan="2" style="height: 5px"></td></tr>
                        <tr>
                            <td><b>*Cinsiyetiniz:</b></td>
                            <td><input type="radio" name="cinsiyet" value="Erkek">Erkek <input type="radio" name="cinsiyet" value="Kız" style="margin-left: 60px">Kadın</td>
                        </tr>
                        <tr><td colspan="2" style="height: 5px"></td></tr>
                        <tr>
                            <td><b>*Okuduğunuz Lise:</b></td>
                            <td><input type="text" name="lise"></td>
                        </tr>
                        <tr><td colspan="2" style="height: 5px"></td></tr>
                        <tr>
                            <td><b>*Liseye Başlangıç/Bitiş Tarihleri</b></td>
                            <td>
                                <select name="yil1">
                                   <option>2005</option>
                                   <option>2006</option>
                                   <option>2007</option>
                                   <option>2008</option>
                                   <option>2009</option>
                                   <option>2010</option>
                                   <option>2011</option>
                                   <option>2012</option>
                                   <option>2013</option>
                                   <option>2014</option>
                                   <option>2015</option>
                                   <option>2016</option>
                               </select>
                                   <select style="margin-left: 62px" name="yil2">
                                   <option>-</option>
                                   <option>2005</option>
                                   <option>2006</option>
                                   <option>2007</option>
                                   <option>2008</option>
                                   <option>2009</option>
                                   <option>2010</option>
                                   <option>2011</option>
                                   <option>2012</option>
                                   <option>2013</option>
                                   <option>2014</option>
                                   <option>2015</option>
                                   <option>2016</option>
                                </select>
                            </td>
                         
                        </tr>
                        <tr><td colspan="2" style="height: 5px"></td></tr>
                        <tr>
                            <td><b>Okuduğunuz Üniversite:</b></td>
                            <td><input type="text" placeholder="Üni Okuyanlar Doldurmalıdır" name="uni"></td>
                        </tr>
                        <tr><td colspan="2" style="height: 5px"></td></tr>
                        <tr>
                            <td><b>Bölümünüz:</b></td>
                            <td><input type="text" placeholder="Üni Okuyanlar Doldurmalıdır" name="bolum"></td>
                        </tr>
                        <tr><td colspan="2" style="height: 5px"></td></tr>
                        <tr>
                            <td><b>*Mesleğiniz:</b></td>
                            <td><input type="text" name="meslek"></td>
                        </tr>
                        <tr><td colspan="2" style="height: 5px"></td></tr>
                        <tr>
                            <td><b>*Mail Adresiniz:</b></td>
                            <td><input type="text" name="mail"></td>
                        </tr>
                        <tr><td colspan="2" style="height: 5px"></td></tr>
                        <tr>
                            <td><b>Adres:</b></td>
                            <td><textarea rows="8" cols="25" name="adres"></textarea></td>
                        </tr>
                        <tr><td colspan="2" style="height: 5px"></td></tr>
                        <tr>
                            <td rowspan="6"><b>Hobiler:</b></td>
                            <td><input type="checkbox" name="hobi1" value="Spor Yapmak">Spor Yapmak</td>
                        
                        </tr>
                        <tr>
                            <td><input type="checkbox" name="hobi2" value="Müzik Dinlemek">Müzik Dinlemek</td>
                        </tr>
                        <tr>
                            <td><input type="checkbox" name="hobi3" value="Gezmek">Gezmek</td>
                        </tr>
                        <tr>
                            <td><input type="checkbox" name="hobi4" value="Bisiklet Sürmek">Bisiklet Sürmek</td>
                        </tr>
                        <tr>
                            <td><input type="checkbox" name="hobi5" value="Kitap Okumak">Kitap Okumak</td>
                        </tr>
                        <tr>
                            <td><input type="checkbox" name="hobi6" value="Diğer">Diğer</td>
                        </tr>
                        <tr><td colspan="2" style="height: 5px"></td></tr>
                        <tr>
                            <td><b>*Şifreniz:</b></td>
                            <td><input type="password" name="ps1" ></td>
                        </tr>
                        <tr><td colspan="2" style="height: 5px"></td></tr>
                        <tr>
                            <td><b>*Şifreyi Tekrar Giriniz:</b></td>
                            <td><b><input type="password" name="ps"></b></td>
                        </tr>
                        <tr><td colspan="2" style="height: 5px"></td></tr>
                        <tr>
                            <td style="text-align: center" colspan="2"><input type="submit" value="Kaydet" style="color: #d25313;margin-bottom: 20px;"></td>
                        </tr>
                    </table>
                 </fieldset>
                 </form> 
                </center>
                
            </div>
        </div>
    </body>
</html>
