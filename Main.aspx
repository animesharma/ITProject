<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Main.aspx.cs" Inherits="Main" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="sm1" runat="server" />
        <asp:UpdatePanel ID="up1" runat="server">
            <ContentTemplate>
                <asp:Label ID="headlb" runat="server" Text="AJAX Calculator : "></asp:Label>
            <br />
            <asp:Label ID="cntlb" runat="server" Text=""></asp:Label>
            <br />
            <asp:Label ID="num1lb" runat="server" Text="Enter first number : "></asp:Label>
            <asp:TextBox ID="num1tb" runat="server" PlaceHolder="Enter a number"></asp:TextBox>
            <asp:RequiredFieldValidator runat="server" ControlToValidate="num1tb" ErrorMessage="First Number is Required!" ForeColor="Red"></asp:RequiredFieldValidator>
            <asp:CompareValidator runat="server" Operator="DataTypeCheck" Type="Double" ControlToValidate="num1tb" ErrorMessage="Value must be a number" ForeColor="DarkRed"/>
            <br />
            <asp:Label ID="num2lb" runat="server" Text="Enter second number : "></asp:Label>
            <asp:TextBox ID="num2tb" runat="server" PlaceHolder="Enter a number"></asp:TextBox>
            <asp:RequiredFieldValidator runat="server" ControlToValidate="num2tb" ErrorMessage="Second Number is Required!" ForeColor="Red"></asp:RequiredFieldValidator>
            <asp:CompareValidator runat="server" Operator="DataTypeCheck" Type="Double" ControlToValidate="num2tb" ErrorMessage="Value must be a number" ForeColor="DarkRed"/>
            <br />
            <asp:Label ID="op" runat="server" Text="Select Operator : "></asp:Label>
            <asp:DropDownList ID="opddl" runat="server">
                <asp:ListItem Value="+" Text="Addition"></asp:ListItem>
                <asp:ListItem Value="-" Text="Subtraction"></asp:ListItem>
                <asp:ListItem Value="*" Text="Multiplication"></asp:ListItem>
                <asp:ListItem Value="/" Text="Division"></asp:ListItem>
            </asp:DropDownList>
            <br />
            <asp:Label runat="server" ID="histlb"></asp:Label>
            <asp:CheckBoxList ID="hiscbl" runat ="server">
                <asp:ListItem Value ="1" Text="Store Calculation History"></asp:ListItem>
            </asp:CheckBoxList>
            <br />
            <asp:Button runat="server" ID="calc" Text="Calculate!" OnClick="calc_Click" />
            <br />
            <asp:Label ID="reslb" runat="server" Text="Result : "></asp:Label>
            </ContentTemplate>         
        </asp:UpdatePanel>            
            <br />
            <br />
        <asp:UpdatePanel ID="panel" runat="server">
            <ContentTemplate>
                <asp:Label ID="hislb" runat="server" Text="Show Calculation History : "></asp:Label>
                <asp:RadioButtonList runat="server" ID="histrbl">
                    <asp:ListItem Value="5" Text="Last 5 items"></asp:ListItem>
                    <asp:ListItem Value="10" Text="Last 10 items"></asp:ListItem>
                </asp:RadioButtonList>
                <br />
                <asp:Button ID="hist" Text="Show History!" runat="server" OnClick="hist_Click" />
                <br />
            
                <asp:GridView runat="server" ID="hist_grid" AutoGenerateColumns="false">
                    <Columns>
                        <asp:BoundField DataField="num1" HeaderText="First Number" />
                        <asp:BoundField DataField="op" HeaderText="Operator" />
                        <asp:BoundField DataField="num2" HeaderText="Second Number" />
                        <asp:BoundField DataField="result" HeaderText="Result" />
                    </Columns>
                </asp:GridView>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:Label runat="server" ID="themelb" Text="Select a Theme : "></asp:Label>
        <br />
        <asp:DropDownList ID="themeddl" runat="server" AutoPostBack="true" OnSelectedIndexChanged="themeddl_SelectedIndexChanged">
            <asp:ListItem Value="Light" Text="Light" Selected="True"></asp:ListItem>
            <asp:ListItem Value="Dark" Text="Dark"></asp:ListItem>
        </asp:DropDownList>
    </form>
</body>
</html>
