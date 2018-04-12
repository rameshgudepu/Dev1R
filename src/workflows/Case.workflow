<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>case_failed_alert</fullName>
        <description>case failed alert</description>
        <protected>false</protected>
        <recipients>
            <recipient>eswar.acc1@ar.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>CustomEmailFolder/CustomTemplate1</template>
    </alerts>
    <rules>
        <fullName>CaseTestRule1</fullName>
        <actions>
            <name>case_failed_alert</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.CaseNumber</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
