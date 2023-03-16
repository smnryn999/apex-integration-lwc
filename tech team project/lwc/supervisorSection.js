import { LightningElement, api, wire } from "lwc";
import { getRecord, getFieldValue } from "lightning/uiRecordApi";
import SUPERVISOR from "@salesforce/schema/SA_Detail__c.Supervisor__c";

export default class SupervisorSection extends LightningElement {
  @api recordId;

  @wire(getRecord, { recordId: "$recordId", fields: [SUPERVISOR] }) sadetail;

  get supervisorId() {
    return getFieldValue(this.sadetail.data, SUPERVISOR);
  }
}
