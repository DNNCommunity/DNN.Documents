<%@ Control language="vb" AutoEventWireup="false" Inherits="DotNetNuke.Modules.Documents.Document"   TargetSchema="http://schemas.microsoft.com/intellisense/ie5" CodeBehind="Document.ascx.vb" Explicit="True" %>
<div class="DNN_Documents">
  <asp:datagrid id="grdDocuments" runat="server" datakeyfield="ItemID" enableviewstate="False" autogeneratecolumns="False" GridLines="None" CssClass="dnnGrid" Width="100%">
    <headerstyle cssclass="dnnGridHeader" verticalalign="Top" />
    <itemstyle cssclass="dnnGridItem" horizontalalign="Left" />
    <alternatingitemstyle cssclass="dnnGridAltItem" />
    <edititemstyle cssclass="dnnFormInput" />
    <selecteditemstyle cssclass="dnnFormError" />
    <footerstyle cssclass="dnnGridFooter" />
    <pagerstyle cssclass="dnnGridPager" />
    <Columns>
      <asp:TemplateColumn>
        <ItemTemplate>
          <asp:hyperlink id=editLink runat="server" visible="<%# IsEditable %>" navigateurl='<%# EditURL("ItemID",DataBinder.Eval(Container.DataItem,"ItemID")) %>'>
            <asp:image id="editLinkImage" imageurl="~/images/edit.gif" visible="<%# IsEditable %>" alternatetext="Edit" runat="server" resourcekey="Edit" />
          </asp:hyperlink>
        </ItemTemplate>
      </asp:TemplateColumn>
    </Columns>
  </asp:datagrid>
  </div>
