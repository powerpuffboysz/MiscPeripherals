package miscperipherals.module;

import miscperipherals.core.Module;
import miscperipherals.safe.ReflectionStore;
import net.minecraft.item.ItemStack;
import net.minecraft.network.packet.NetHandler;
import net.minecraftforge.oredict.OreDictionary;

import com.google.common.io.ByteArrayDataInput;

public class ModuleAdditionalPipes extends Module {
	@Override
	public void onPreInit() {
		
	}

	@Override
	public void onInit() {
		
	}

	@Override
	public void onPostInit() {
		ReflectionStore.initAdditionalPipes();
		if (ReflectionStore.blockChunkLoaderB != null) OreDictionary.registerOre("MiscPeripherals$chunkLoader", new ItemStack(ReflectionStore.blockChunkLoaderB, 1, OreDictionary.WILDCARD_VALUE));
	}

	@Override
	public void handleNetworkMessage(NetHandler source, boolean isClient, ByteArrayDataInput data) {
		
	}
}
