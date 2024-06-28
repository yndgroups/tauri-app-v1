export interface File {
  key: string;
  path: string;
  name?: string;
  editStatus?: boolean;
  children?: Array<File>;
  fileContent?: string;
}
