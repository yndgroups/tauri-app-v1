import { defineStore } from 'pinia';
import { store } from './index';

interface UserState {
  userInfo: any;
}

export const useUserStore = defineStore({
  id: 'user',
  state: (): UserState => ({
    userInfo: null,
  }),
  getters: {
    getUserInfo() {
      return {};
    },
  },
  actions: {
    setUserInfo(info: any | null) {
      this.userInfo = info;
    },
  },
});

export function useUserStoreWithOut() {
  return useUserStore(store);
}
