<#include "admindashboard_utils.ftl">

<@adminDashboardPanel title='#i18n{portal.search.manage_advanced_parameters.pageTitle}' icon='search' parentId='technical_settings' childId='searchParameters' >
    <@tform  name='search_advanced_parameters' action='jsp/admin/search/DoModifyAdvancedParameters.jsp' >
        <@input type='hidden' name='token' value='${token}' />
        <@formGroup labelFor='type_filter' labelKey='${i18n("portal.search.advanced_parameters.typeFilter.label")}'>
            <@select name="type_filter">
              <#list [ "none", "option", "radio" "checkbox"] as display_option>
                <option value="${display_option}" <#if type_filter=display_option>selected="selected"</#if>> #i18n{portal.search.advanced_parameters.typeFilter.${display_option}}</option>
              </#list>
            </@select>
        </@formGroup> 
        <!-- DATE FILTER -->
        <@formGroup labelFor='date_filter' labelKey='${i18n("portal.search.advanced_parameters.dateFilter.label")}'>
            <@select name="date_filter">
              <#list [ "0", "1"] as b_active>
                <option value="${b_active}" <#if date_filter=b_active>selected="selected"</#if>> #i18n{portal.search.advanced_parameters.activeLabel.${b_active}}</option>
              </#list>
            </@select>
        </@formGroup> 
        <!-- TAG FILTER -->
        <@formGroup labelFor='tag_filter' labelKey='${i18n("portal.search.advanced_parameters.tagFilter.label")}'>
            <@select name="tag_filter">
            <#list [ "0", "1"] as b_active>
            <option value="${b_active}" <#if tag_filter=b_active>selected="selected"</#if>> #i18n{portal.search.advanced_parameters.activeLabel.${b_active}}</option>
          </#list>
            </@select>
        </@formGroup> 
        <!-- DEFAULT OPERATOR -->
        <@formGroup labelFor='default_operator' labelKey='${i18n("portal.search.advanced_parameters.defaultOperator.label")}'>
            <@select name="default_operator">
              <#list [ "OR", "AND"] as operator>
                <option value="${operator}" <#if default_operator=operator>selected="selected"</#if>> #i18n{portal.search.advanced_parameters.defaultOperator.${operator}}</option>
              </#list>
            </@select>
        </@formGroup> 
        <!-- HELP MESSAGE -->
        <@formGroup labelFor='help_message' labelKey='${i18n("portal.search.advanced_parameters.helpMessage.label")}'>
            <@input type='textarea' class='richtext' name='help_message' id='help_message' value=help_message!'' />
        </@formGroup>   
        <@formGroup hideLabel=['all']>
					<@button name='submit' type='submit' title='${i18n("portal.util.labelModify")}' buttonIcon='check' />
        </@formGroup>   
    </@tform>
</@adminDashboardPanel>

<#include "/admin/util/editor/editor.ftl" />
<@initEditor />
