<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="register.aspx.vb" Inherits="pasconcept20.register1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

        <script type="text/javascript">
!function(T,l,y){var S=T.location,u="script",k="instrumentationKey",D="ingestionendpoint",C="disableExceptionTracking",E="ai.device.",I="toLowerCase",b="crossOrigin",w="POST",e="appInsightsSDK",t=y.name||"appInsights";(y.name||T[e])&&(T[e]=t);var n=T[t]||function(d){var g=!1,f=!1,m={initialize:!0,queue:[],sv:"4",version:2,config:d};function v(e,t){var n={},a="Browser";return n[E+"id"]=a[I](),n[E+"type"]=a,n["ai.operation.name"]=S&&S.pathname||"_unknown_",n["ai.internal.sdkVersion"]="javascript:snippet_"+(m.sv||m.version),{time:function(){var e=new Date;function t(e){var t=""+e;return 1===t.length&&(t="0"+t),t}return e.getUTCFullYear()+"-"+t(1+e.getUTCMonth())+"-"+t(e.getUTCDate())+"T"+t(e.getUTCHours())+":"+t(e.getUTCMinutes())+":"+t(e.getUTCSeconds())+"."+((e.getUTCMilliseconds()/1e3).toFixed(3)+"").slice(2,5)+"Z"}(),iKey:e,name:"Microsoft.ApplicationInsights."+e.replace(/-/g,"")+"."+t,sampleRate:100,tags:n,data:{baseData:{ver:2}}}}var h=d.url||y.src;if(h){function a(e){var t,n,a,i,r,o,s,c,p,l,u;g=!0,m.queue=[],f||(f=!0,t=h,s=function(){var e={},t=d.connectionString;if(t)for(var n=t.split(";"),a=0;a<n.length;a++){var i=n[a].split("=");2===i.length&&(e[i[0][I]()]=i[1])}if(!e[D]){var r=e.endpointsuffix,o=r?e.location:null;e[D]="https://"+(o?o+".":"")+"dc."+(r||"services.visualstudio.com")}return e}(),c=s[k]||d[k]||"",p=s[D],l=p?p+"/v2/track":config.endpointUrl,(u=[]).push((n="SDK LOAD Failure: Failed to load Application Insights SDK script (See stack for details)",a=t,i=l,(o=(r=v(c,"Exception")).data).baseType="ExceptionData",o.baseData.exceptions=[{typeName:"SDKLoadFailed",message:n.replace(/\./g,"-"),hasFullStack:!1,stack:n+"\nSnippet failed to load ["+a+"] -- Telemetry is disabled\nHelp Link: https://go.microsoft.com/fwlink/?linkid=2128109\nHost: "+(S&&S.pathname||"_unknown_")+"\nEndpoint: "+i,parsedStack:[]}],r)),u.push(function(e,t,n,a){var i=v(c,"Message"),r=i.data;r.baseType="MessageData";var o=r.baseData;return o.message='AI (Internal): 99 message:"'+("SDK LOAD Failure: Failed to load Application Insights SDK script (See stack for details) ("+n+")").replace(/\"/g,"")+'"',o.properties={endpoint:a},i}(0,0,t,l)),function(e,t){if(JSON){var n=T.fetch;if(n&&!y.useXhr)n(t,{method:w,body:JSON.stringify(e),mode:"cors"});else if(XMLHttpRequest){var a=new XMLHttpRequest;a.open(w,t),a.setRequestHeader("Content-type","application/json"),a.send(JSON.stringify(e))}}}(u,l))}function i(e,t){f||setTimeout(function(){!t&&m.core||a()},500)}var e=function(){var n=l.createElement(u);n.src=h;var e=y[b];return!e&&""!==e||"undefined"==n[b]||(n[b]=e),n.onload=i,n.onerror=a,n.onreadystatechange=function(e,t){"loaded"!==n.readyState&&"complete"!==n.readyState||i(0,t)},n}();y.ld<0?l.getElementsByTagName("head")[0].appendChild(e):setTimeout(function(){l.getElementsByTagName(u)[0].parentNode.appendChild(e)},y.ld||0)}try{m.cookie=l.cookie}catch(p){}function t(e){for(;e.length;)!function(t){m[t]=function(){var e=arguments;g||m.queue.push(function(){m[t].apply(m,e)})}}(e.pop())}var n="track",r="TrackPage",o="TrackEvent";t([n+"Event",n+"PageView",n+"Exception",n+"Trace",n+"DependencyData",n+"Metric",n+"PageViewPerformance","start"+r,"stop"+r,"start"+o,"stop"+o,"addTelemetryInitializer","setAuthenticatedUserContext","clearAuthenticatedUserContext","flush"]),m.SeverityLevel={Verbose:0,Information:1,Warning:2,Error:3,Critical:4};var s=(d.extensionConfig||{}).ApplicationInsightsAnalytics||{};if(!0!==d[C]&&!0!==s[C]){method="onerror",t(["_"+method]);var c=T[method];T[method]=function(e,t,n,a,i){var r=c&&c(e,t,n,a,i);return!0!==r&&m["_"+method]({message:e,url:t,lineNumber:n,columnNumber:a,error:i}),r},d.autoExceptionInstrumented=!0}return m}(y.cfg);(T[t]=n).queue&&0===n.queue.length&&n.trackPageView({})}(window,document,{
src: "https://az416426.vo.msecnd.net/scripts/b/ai.2.min.js", // The SDK URL Source
//name: "appInsights", // Global SDK Instance name defaults to "appInsights" when not supplied
//ld: 0, // Defines the load delay (in ms) before attempting to load the sdk. -1 = block page load and add to head. (default) = 0ms load after timeout,
//useXhr: 1, // Use XHR instead of fetch to report failures (if available),
//crossOrigin: "anonymous", // When supplied this will add the provided value as the cross origin attribute on the script tag 
cfg: { // Application Insights Configuration
    instrumentationKey: "78d202c5-fd94-4940-9bc9-816f1301cfbf",
    autoTrackPageVisitTime: true,
    crossOrigin: "anonymous",
    /* ...Other Configuration Options... */
}});
        </script>

    <%-- Favicons and the like --%>
    <link rel="apple-touch-icon" sizes="180x180" href="~/Content/favicons/apple-touch-icon.png" />
    <link rel="icon" type="image/png" sizes="32x32" href="~/Content/favicons/favicon-32x32.png" />
    <link rel="icon" type="image/png" sizes="16x16" href="~/Content/favicons/favicon-16x16.png" />
    <link rel="manifest" href="~/Content/favicons/site.webmanifest" />

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Register</title>
</head>
<body style="background-color: white; padding-top: 200px;">
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" EnableCdn="true" runat="server">
        </telerik:RadScriptManager>
        <table align="center" class="RegisterCentralPanel">
            <tr>
                <td style="text-align: center">
                    <asp:Image ID="Image3" runat="server" ImageUrl="~/Images/logo.png" meta:resourcekey="Image3Resource1" />
                </td>
            </tr>
            <tr>
                <td  class="Titulo3" align="center">
                    <asp:Label ID="lblVersinoName" runat="server" Text="30 days Free Trial"></asp:Label> 
                </td>
            </tr>
            <tr>
                <td style="padding-left:15px;text-align:center">
                    <br />
                    To create your <b>30 days Trial PASconcept account</b>, enter your email address and the characters shown below.<br />
                    <asp:Label ID="lblMsg" runat="server" CssClass="Error" meta:resourcekey="lblMsgResource1"></asp:Label>
                    <br />
                    </td>
            </tr>
            <tr>
                <td style="text-align: left; padding-left: 50px">
                    <br />
                    <telerik:RadTextBox ID="txtEmail" runat="server" Skin="MetroTouch" EmptyMessage="Email" LabelWidth="64px" Resize="None" Width="400px" meta:resourcekey="txtEmailResource1">
                    </telerik:RadTextBox>
                    &nbsp;<br />
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate="txtEmail" ValidationGroup="SubmitInfo"
                        runat="server" ErrorMessage="(*) Enter an valid email address" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                        Display="Dynamic" meta:resourcekey="RegularExpressionValidator1Resource1"></asp:RegularExpressionValidator>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtEmail" ValidationGroup="SubmitInfo"
                        ErrorMessage="(*) Email is Required" Display="Dynamic" meta:resourcekey="RequiredFieldValidator2Resource1"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="text-align: left; padding-left: 50px;padding-top:15px">
                    <telerik:RadCaptcha ID="RadCaptcha1" runat="server" Skin="MetroTouch" ValidationGroup="SubmitInfo" 
                        CaptchaTextBoxLabel="" CaptchaTextBoxLabelCssClass="Normal" EnableRefreshImage="True" meta:resourcekey="RadCaptcha1Resource1" CaptchaLinkButtonText="Generate new image">
                        <CaptchaImage LineNoise="Low" TextLength="4" BackgroundColor="#dff3ff" />
                    </telerik:RadCaptcha>
                </td>
            </tr>
            <tr>
                <td style="text-align: right; padding-right: 40px; padding-bottom:15px; height: 40px; vertical-align: middle">&nbsp;
                    <br />
                    <telerik:RadButton ID="btbCreate" runat="server" Text="Create PASconcept account" Skin="BlackMetroTouch" ValidationGroup="SubmitInfo" meta:resourcekey="btbCreateResource1">
                </telerik:RadButton>
                    <br />
                </td>
            </tr>
        </table>
        <table align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td align="center">
                    <asp:HyperLink ID="lnkHelp" runat="server" CssClass="EnlaceGrisSmall" NavigateUrl="http://blog.pasconcept.com"
                        Target="_blank" meta:resourcekey="lnkHelpResource1">Help</asp:HyperLink>
                    &nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; <asp:HyperLink ID="HyperLink2" runat="server" CssClass="EnlaceGrisSmall"
                        NavigateUrl="https://pasconcept.com/Legal/ENG/Terms.html" Target="_blank" meta:resourcekey="HyperLink2Resource1">Terms & Conditions</asp:HyperLink>
                    &nbsp;</td>
            </tr>
        </table>
        <asp:Label ID="lblVersion" runat="server" Text="0" Visible="False" meta:resourcekey="lblVersionResource1"></asp:Label>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:cnnProjectsAccounting %>" 
            InsertCommand="sys_preUser_INSERT" InsertCommandType="StoredProcedure">
            <InsertParameters>
                <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                <asp:ControlParameter ControlID="txtEmail" Name="Email" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="lblVersion" Name="Version" PropertyName="Text" Type="Int32" />
                <asp:Parameter Direction="Output" Name="GUID_OUT" DbType="Guid" />
            </InsertParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
