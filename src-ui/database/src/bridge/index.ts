import { AnyObject, Response } from '../../env';
import { invoke } from '@tauri-apps/api/tauri';
window.Bridge = {
  invoke: async (handler: string, params: AnyObject): Promise<Response> => {
    console.log('invoke =>', handler, params);
    const resut: Response = await invoke(handler, params);
    console.log(`'invoke => code:'${resut.code}, msg: ${resut.msg}, data:`, resut.data);
    return resut;
  },
  delete: async (handler: string, id: string | number, tableName: string) => {
    const resut: Response = await invoke(handler, { id: id, tableName: tableName });
    console.log(`'invoke => code:'${resut.code}, msg: ${resut.msg}, data:`, resut.data);
    return resut;
  },
};
