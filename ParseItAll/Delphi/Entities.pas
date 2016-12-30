unit Entities;

interface

type
  TJobNode = record
    Tag: string;
    Index: integer;
    TagID: string;
    ClassName: string;
    Name: string;
  end;

  TJobNodes = TArray<TJobNode>;

  TJobRuleLink = record
    Level: string;
    Nodes: TJobNodes;
  end;

  TJobRuleLinks = TArray<TJobRuleLink>;

  TJobRuleRecord = record
    Key: string;
    Nodes: TJobNodes;
  end;

  TJobRuleRecords = TArray<TJobRuleRecord>;

  TJobRule = record
    Links: TJobRuleLinks;
    Records: TJobRuleRecords;
    ContainerOffset: Integer;
  end;

  TJobRules = TArray<TJobRule>;

  TJobLevel = record
    Level: Integer;
    JobRules: TJobRules;
  end;

  TJob = class

  end;

implementation

end.
