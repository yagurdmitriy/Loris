<!-- table with candidate profile info -->
<table cellpadding="2" class="table table-info table-bordered dynamictable" style="max-width:auto">
  <!-- column headings -->
  <thead>
  <tr class="info">
    <th>
      DOB
    </th>
    {if $candidate.EDC!=""}
      <th>
        EDC
      </th>
    {/if}
    <th>
      Biological Sex
    </th>
    <th>
      Project
    </th>
    {foreach from=$candidate.DisplayParameters item=value key=name}
      <th>
        {$name}
      </th>
    {/foreach}
  </tr>
  </thead>
  <!-- candidate data -->
  <tbody>
  <tr>
    <td>
      {$candidate.DoB}
    </td>
    {if $candidate.EDC!=""}
      <td>
        {$candidate.EDC}
      </td>
    {/if}
    <td>
      {$candidate.Sex}
    </td>
      <td>
        {$candidate.ProjectTitle}
      </td>
    {foreach from=$candidate.DisplayParameters item=value key=name}
      <td>
        {$value}
      </td>
    {/foreach}
  </tr>
  </tbody>
</table>

<div class="col-xs-12 row">
    {$actions}
</div>
<br>
<br>
<br>
<br>
<br>
<br>

<!-- table title -->
<strong>List of Visits (Time Points)</strong>
<!-- list of timepoints table -->
<table style="margin-top:0" class="table table-hover table-primary table-bordered dynamictable" cellpadding="2">
    <!-- table column headings -->
    <thead>
        <tr class="info">
            <th>Visit Label<BR>(Click to Open)</th>
            <th>Cohort</th>
            <th>Site</th>
            <th>Project</th>
            <th>Stage</th>
            <th>Stage Status</th>
            <th>Date of Stage</th>
            <th>Sent To DCC</th>
            <th>Imaging Scan Done</th>
            <th>Feedback</th>
            <th>BVL QC</th>
            <th>BVL Exclusion</th>
            <th>Registered By</th>
        </tr>
    </thead>
    <tbody>
    {section name=timepoint loop=$timePoints}
        <tr>
            <td><a href="{$baseurl|default}/instrument_list/?candID={$candID}&sessionID={$timePoints[timepoint].SessionID}">{$timePoints[timepoint].Visit_label}</a></td>

            <td>{$timePoints[timepoint].CohortTitle}</td>

            <td>{$timePoints[timepoint].SiteAlias}</td>
            <td>{$timePoints[timepoint].ProjectName}</td>

            {if $timePoints[timepoint].staticStage|default != "" || $timePoints[timepoint].Current_stage == "Not Started"}
            <td colspan="3">{$timePoints[timepoint].Current_stage}</td>
            {else}
            <td>{$timePoints[timepoint].Current_stage}</td>
            <td>{$timePoints[timepoint].currentStatus}</td>
            <td>{$timePoints[timepoint].currentDate}</td>
            {/if}

            <td>
            {if $timePoints[timepoint].Submitted == "Y"}
        	    <img src="{$baseurl|default}/images/check_blue.gif" border="0" />
            {else}
        	    -
            {/if}
            </td>
            <td>
            {if $timePoints[timepoint].Scan_done != ""}
                    {if $timePoints[timepoint].Scan_done == 'Y'}
                        {assign var="scan_done" value="Yes"}
                        <a href="{$baseurl|default}/imaging_browser/viewSession/?sessionID={$timePoints[timepoint].SessionID}" class="timepoint_list">
                        {$scan_done}</a>
                    {else}
                        {assign var="scan_done" value="No"}
                        {$scan_done}
                    {/if}
            {else}
                <img alt="Data Missing" src="{$baseurl|default}/images/help2.gif" border=0>
            {/if}
            </td>

            <td bgColor="{$timePoints[timepoint].feedbackColor}">
            {if $timePoints[timepoint].feedbackCount}
                {$timePoints[timepoint].feedbackStatus}
            {else}
                -
            {/if}
            </td>

            <td>
            {if $timePoints[timepoint].BVLQCStatus}
                {$timePoints[timepoint].BVLQCType}
            {else}
                <img src="{$baseurl|default}/images/delete.gif" border="0" />
            {/if}
            </td>

            <td>
            {if $timePoints[timepoint].BVLQCExclusion}
                {if $timePoints[timepoint].BVLQCExclusion == 'Not Excluded'}
                Pass
                {else}
                Fail
                {/if}
            {else}
                <img src="{$baseurl|default}/images/delete.gif" border="0" />
            {/if}
            </td>

            <td>
                {$timePoints[timepoint].Real_name}
            </td>
        </tr>
    {sectionelse}
        <tr><td colspan="10">You do not have access to any timepoints registered for this candidate.</td></tr>
    {/section}
    </tbody>
</table>
