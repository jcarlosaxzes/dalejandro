<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/adm/ADM_Main_Responsive.Master" CodeBehind="BBtest.aspx.vb" Inherits="pasconcept20.BBtest" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="demo-containers">
        <div class="demo-container" runat="server" id="containerDiv">
            <telerik:RadCalendar RenderMode="Lightweight" ID="RadCalendar1" runat="server" EnableWeekends="false" ShowRowHeaders="false" 
                FirstDayOfWeek="Monday" ShowOtherMonthsDays="false" ShowFastNavigationButtons="false">
                <ClientEvents OnDateSelected="Cal1Change" />
            </telerik:RadCalendar>
            <telerik:RadCalendar RenderMode="Lightweight" ID="RadCalendar2" runat="server"  EnableWeekends="false" ShowRowHeaders="false" 
                FirstDayOfWeek="Monday" ShowOtherMonthsDays="false" ShowFastNavigationButtons="false">
                <ClientEvents OnDateSelected="Cal1Change" />
            </telerik:RadCalendar>
        </div>
    </div>
    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">

        <script type="text/javascript">


            var cal1;
            var cal2;
            var SelectedRange = true;
            var DateRange = Array();
            var disableCal1 = false;

            function biggerThanOrEqual(A, B) {
                if (A[0] > B[0])
                    return true;
                if (A[0] < B[0])
                    return false;

                if (A[1] > B[1])
                    return true;
                if (A[1] < B[1])
                    return false;

                if (A[2] >= B[2])
                    return true;

                return false;
                return false;
            }

            function tripleToDate(T) {
                return new Date(T[0], T[1]-1, T[2]);
            }
            function dateToTriple(D) {
                return [D.getFullYear(), D.getMonth()+1, D.getDate()];
            }

            Date.prototype.addDays = function (days) {
                var date = new Date(this.valueOf());
                date.setDate(date.getDate() + days);
                return date;
            }

            function Cal1Change(sender, eventArgs) {
                if (disableCal1)
                    return;

                var date = eventArgs.get_renderDay().get_date();
                disableCal1 = true;
                if (SelectedRange || biggerThanOrEqual(DateRange[0] , date)) {
                    DateRange[0] = date;
                    var selectedDates = cal1.get_selectedDates();
                    cal1.unselectDates(selectedDates);
                    selectedDates = cal2.get_selectedDates();
                    cal2.unselectDates(selectedDates);
                    cal1.selectDate(date, false)
                    cal2.selectDate(date, false)
                    SelectedRange = false;
                }
                else {
                    DateRange[1] = date;
                    var startDate = tripleToDate(DateRange[0]);
                    var endDate = tripleToDate(DateRange[1]);
                    var selectedDates = [];
                    while (startDate <= endDate) {
                        if (startDate.getDay()> 0 && startDate.getDay() < 6) {
                            selectedDates.push(dateToTriple(startDate));
                        }
                        startDate = startDate.addDays(1);
                    }
                    if (selectedDates.length == 0) {
                        return;
                    }
                    cal1.selectDates(selectedDates, false);
                    cal2.selectDates(selectedDates, false);
                    SelectedRange = true;
                }

                disableCal1 = false;

            }



            $(function () {

                cal1 = $find("<%= RadCalendar1.ClientID %>");
                cal2 = $find("<%= RadCalendar2.ClientID %>");
                var date1 = new Date(<%= LocalAPI.DateTimeToUnixTimeStamp(DateTime.Now) * 1000 %>);
                var date2 = new Date(<%= LocalAPI.DateTimeToUnixTimeStamp(DateTime.Now.AddMonths(1)) * 1000 %>);
                DateRange[0] = date1;
                DateRange[1] = date1;

                var triplet1 = [date1.getFullYear(), date1.getMonth() + 1, 1];
                var triplet2 = [date2.getFullYear(), date2.getMonth() + 1, 1];
                cal1.navigateToDate(triplet1);
                cal2.navigateToDate(triplet2);

        });

            

        </script>
    </telerik:RadScriptBlock>
</asp:Content>
